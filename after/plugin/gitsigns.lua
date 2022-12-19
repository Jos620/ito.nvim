local status, gitsigns = pcall(require, "gitsigns")
if not status then
  return
end

gitsigns.setup({
  on_attach = function(bufnr)
    local function set(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    set("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function()
        gitsigns.next_hunk()
      end)

      return "<Ignore>"
    end, { expr = true })

    set("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function()
        gitsigns.prev_hunk()
      end)

      return "<Ignore>"
    end, { expr = true })

    -- Actions
    set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    set("n", "<leader>hS", gitsigns.stage_buffer)
    set("n", "<leader>hu", gitsigns.undo_stage_hunk)
    set("n", "<leader>hR", gitsigns.reset_buffer)
    set("n", "<leader>hp", gitsigns.preview_hunk)
    set("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end)
    set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    set("n", "<leader>hd", gitsigns.diffthis)
    set("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end)
    set("n", "<leader>td", gitsigns.toggle_deleted)

    -- Text object
    set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
