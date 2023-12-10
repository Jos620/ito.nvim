local utils = require("jos620.utils")
local keymaps = require("jos620.core.keymaps")

return {
  { -- LSP
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "glepnir/lspsaga.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, buffer)
        keymaps.setup_lsp_keymaps(buffer)

        -- Stop tsserver when in Vue project
        local is_vue_project = lspconfig.util.root_pattern({
          "vue.config.{js,ts}",
          "nuxt.config.{js,ts}",
          "[Aa]pp.vue",
          "./src/[Aa]pp.vue",
          "./src/renderer/src/[Aa]pp.vue",
        })(vim.fn.getcwd())

        if is_vue_project then
          if client.name == "tsserver" then
            client.stop()
          end
        else
          if client.name == "volar" then
            client.stop()
          end
        end
      end

      -- Enable auto completion
      local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp_status and cmp_nvim_lsp.default_capabilities()
        or vim.lsp.protocol.make_client_capabilities()

      -- Folding
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Base LSP config
      local servers = {
        "html",
        "cssls",
        "tailwindcss",
        "rust_analyzer",
        "svelte",
        "prismals",
        "unocss",
        "marksman",
        "tsserver",
        "dockerls",
        "bufls",
        "astro",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Lua
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            -- Add global "vim"
            diagnostics = {
              globals = { "vim" },
            },
            -- Add runtime files
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      -- JSON
      local schemastore_status, schemastore = pcall(require, "schemastore")

      if schemastore_status then
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = {
                enable = true,
              },
            },
            yaml = {
              schemas = schemastore.yaml.schemas(),
              validate = {
                enable = true,
              },
            },
          },
        })
      end

      -- Vue
      lspconfig.volar.setup({
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "json" },
        on_attach = on_attach,
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      -- Golang
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        setting = {
          gopls = {
            completeUnimported = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })

      -- HTMX
      lspconfig.htmx.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "htmx-lsp" },
        filetypes = { "html", "astro" },
      })
    end,
  },

  { -- LSP servers
    {
      "williamboman/mason.nvim",
      lazy = false,
      opts = {
        PATH = "prepend",
      },
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
      },
      lazy = true,
      opts = {
        ensure_installed = {
          "html",
          "cssls",
          "tailwindcss",
          "unocss",
          "volar",
          "svelte",
          "tsserver",
          "rust_analyzer",
          "lua_ls",
          "jsonls",
          "prismals",
          "marksman",
          "vuels",
          "htmx",
          "astro",
        },
      },
    },
  },

  { -- LSP UI
    "glepnir/lspsaga.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lspsaga = require("lspsaga")

      lspsaga.setup({
        ui = {
          border = "rounded",
        },
        move_in_saga = {
          prev = "<C-k>",
          next = "<C-j>",
        },
        finder = {
          keys = {
            toggle_or_open = "<Return>",
            vsplit = "v",
            split = "b",
          },
        },
        definition = {
          edit = "<Return>",
          vsplit = "v",
          split = "b",
        },
        symbol_in_winbar = {
          enable = false,
        },
        beacon = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        hover = {
          open_link = "o",
        },
      })
    end,
  },

  { -- Lint / format
    {
      "mfussenegger/nvim-lint",
      ft = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "css",
        "scss",
        "astro",
      },
      config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
          typescript = { "eslint_d" },
          javascript = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          vue = { "eslint_d" },
          css = { "stylelint" },
          scss = { "stylelint" },
          astro = { "eslint_d" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({
          "BufWritePost",
          "BufEnter",
          "InsertLeave",
        }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })

        keymaps.setup_linting_keymaps(lint)
      end,
    },

    {
      "stevearc/conform.nvim",
      ft = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "lua",
        "css",
        "scss",
        "html",
        "astro",
      },
      config = function()
        local conform = require("conform")

        local function get_javascript_formatters()
          local formatters = { "eslint_d" }
          local prettier_configs = {
            ".prettierrc",
            ".prettierrc.yaml",
          }

          if utils.RootHasFile(prettier_configs) then
            table.insert(formatters, "prettierd")
          end

          return formatters
        end

        local function get_css_formatters()
          local formatters = {}
          local stylelint_configs = {
            ".stylelintrc",
            ".stylelintrc.yaml",
          }

          if utils.RootHasFile(stylelint_configs) then
            table.insert(formatters, "stylelint")
          end

          return formatters
        end

        conform.setup({
          formatters_by_ft = {
            typescript = get_javascript_formatters,
            javascript = get_javascript_formatters,
            typescriptreact = get_javascript_formatters,
            javascriptreact = get_javascript_formatters,
            vue = get_javascript_formatters,
            lua = { "stylua" },
            css = get_css_formatters,
            scss = get_css_formatters,
            html = { "prettierd" },
            astro = { "eslint_d", "prettierd" },
          },
          format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 750,
          },
        })

        keymaps.set({ "n", "v" }, "<Leader>lF", function()
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          })
        end, "Format file or range")
      end,
    },
  },

  { -- Code completion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      vim.opt.completeopt = "menu,menuone,noselect"

      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          -- Move through the list
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),

          -- Docs
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Show / hide the popup
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<M-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          -- Confirm
          ["<Return>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", trigger_characters = { "-" } },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  { -- Snippets
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    {
      "b0o/schemastore.nvim",
      ft = {
        "json",
        "yaml",
      },
    },
  },

  { -- Languages
    { -- Dart (flutter)
      "akinsho/flutter-tools.nvim",
      lazy = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
        require("flutter-tools").setup({
          ui = {
            border = "rounded",
          },
          lsp = {
            on_attach = function(_, buffer)
              keymaps.setup_lsp_keymaps(buffer)
            end,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          },
          widget_guides = {
            enabled = true,
          },
        })
      end,
    },

    { -- Markdown
      "ixru/nvim-markdown",
    },
  },
}
