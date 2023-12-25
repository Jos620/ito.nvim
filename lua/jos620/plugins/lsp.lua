local utils = require("jos620.utils")
local keymaps = require("jos620.core.keymaps")

---@class GetFormattersOptions
---@field linters_only boolean

---Get JavaScript formatters
---@param options? GetFormattersOptions -- Only return linters
---@return string[]                     -- List of linters and formatters
local function get_javascript_formatters(options)
  options = options or { linters_only = false }

  local linters = {}

  local has_eslint = utils.RootHasFile({
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
  })

  if has_eslint then
    table.insert(linters, "eslint_d")
  end

  if options.linters_only then
    return linters
  end

  local formatters = {}

  local has_prettier = utils.RootHasFile({
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
    ".prettier.config.js",
    "prettier.config.mjs",
    "prettier.config.cjs",
    ".prettierrc.toml",
  })

  if has_prettier then
    table.insert(formatters, "prettierd")
  end

  return utils.Flatten({ linters, formatters })
end

---Get CSS formatters
---@param options? GetFormattersOptions -- Only return linters
---@return string[]                     -- List of linters and formatters
local function get_css_formatters(options)
  options = options or { linters_only = false }

  local linters = {}
  local formatters = {}

  local stylelint_configs = {
    ".stylelintrc",
    ".stylelintrc.yaml",
  }

  if utils.RootHasFile(stylelint_configs) then
    table.insert(linters, "stylelint")
  end

  if options.linters_only then
    return linters
  end

  return utils.Flatten({ linters, formatters })
end

return {
  { -- LSP
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, buffer)
        local opts = { noremap = true, silent = true, buffer = buffer }

        keymaps.set("n", "K", vim.lsp.buf.hover, "Show hover doc", opts)

        keymaps.set("n", "gd", function()
          require("telescope.builtin").lsp_definitions({
            reuse_win = true,
          })
        end, "Go to definition", opts)
        keymaps.set("n", "gi", vim.lsp.buf.implementation, "Go to implementation", opts)
        keymaps.set("n", "gr", vim.lsp.buf.references, "Go to references", opts)
        keymaps.set("n", "<Leader>la", vim.lsp.buf.code_action, "Code action", opts)
        keymaps.set("n", "<Leader>lr", vim.lsp.buf.rename, "Rename symbol", opts)

        local diagnostic_opts = {
          float = {
            border = "rounded",
          },
        }

        keymaps.set("n", "<Leader>lj", function()
          vim.diagnostic.goto_next(diagnostic_opts)
        end, "Go to next diagnostic", opts)

        keymaps.set("n", "<Leader>lk", function()
          vim.diagnostic.goto_prev(diagnostic_opts)
        end, "Go to previous diagnostic", opts)

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
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

      -- Folding
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Additional filetypes
      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })

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
        "dockerls",
        "bufls",
        "astro",
        "templ",
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

      -- TypeScript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "."),
      })

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
      config = function()
        local status, mason = pcall(require, "mason")
        if not status then
          return
        end

        mason.setup({
          PATH = "prepend",
        })

        keymaps.set("n", "<Leader>mm", ":Mason<Return>", "Launch Mason")
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
      },
      event = "VeryLazy",
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

  { -- Errors
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local trouble = require("trouble")

      trouble.setup({
        auto_close = true,
        action_keys = {
          open_split = { "<C-b>" },
          open_vsplit = { "<C-v>" },
        },
      })

      keymaps.set("n", "<Leader>lt", trouble.toggle, "Toggle trouble")

      keymaps.set("n", "<Leader>ld", function()
        trouble.open("document_diagnostics")
      end, "Open document diagnostics")
      keymaps.set("n", "<Leader>lw", function()
        trouble.open("workspace_diagnostics")
      end, "Open workspace diagnostics")
    end,
  },

  { -- Lint / format
    { -- Lint
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

        local javascript_linters = get_javascript_formatters({
          linters_only = true,
        })
        local css_linters = get_css_formatters({
          linters_only = true,
        })

        lint.linters_by_ft = {
          typescript = javascript_linters,
          javascript = javascript_linters,
          typescriptreact = javascript_linters,
          javascriptreact = javascript_linters,
          vue = javascript_linters,
          css = css_linters,
          scss = css_linters,
          astro = javascript_linters,
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

        keymaps.set("n", "<Leader>lL", function()
          lint.try_lint()
        end, "Lint file")
      end,
    },

    { -- Format
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

        local javascript_formatters = get_javascript_formatters()
        local css_formatters = get_css_formatters()

        conform.setup({
          formatters_by_ft = {
            typescript = javascript_formatters,
            javascript = javascript_formatters,
            typescriptreact = javascript_formatters,
            javascriptreact = javascript_formatters,
            vue = javascript_formatters,
            lua = { "stylua" },
            css = css_formatters,
            scss = css_formatters,
            html = { "prettierd" },
            astro = javascript_formatters,
            templ = { "templ" },
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
