return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  config = function()
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not cmp_nvim_lsp_status then
      return
    end

    local on_attach = function(client, buffer)
      require("jos620.core.keymaps").setup_lsp_keymaps(buffer)

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
    local capabilities = cmp_nvim_lsp.default_capabilities()

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
  end,
}
