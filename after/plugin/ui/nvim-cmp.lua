local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      local luasnip_status, luasnip = pcall(require, "luasnip")
      if not luasnip_status then
        return
      end

      luasnip.lsp_expand(args.body)
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

    -- Confim
    ["<Return>"] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", trigger_characters = { "-" } },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),

  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})
