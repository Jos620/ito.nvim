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
    set("n", "<Leader>gj", function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function()
        gitsigns.next_hunk()
      end)

      return "<Ignore>"
    end, { expr = true })

    set("n", "<Leader>gk", function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function()
        gitsigns.prev_hunk()
      end)

      return "<Ignore>"
    end, { expr = true })

    -- Actions
    set({ "n", "v" }, "<Leader>gs", ":Gitsigns stage_hunk<CR>")
    set({ "n", "v" }, "<Leader>gr", ":Gitsigns reset_hunk<CR>")
    set("n", "<Leader>gS", gitsigns.stage_buffer)
    set("n", "<Leader>gu", gitsigns.undo_stage_hunk)
    set("n", "<Leader>gR", gitsigns.reset_buffer)
    set("n", "<Leader>gp", gitsigns.preview_hunk)
    set("n", "<Leader>gl", function()
      gitsigns.blame_line({ full = true })
    end)
    set("n", "<Leader>gb", gitsigns.toggle_current_line_blame)
    set("n", "<Leader>gd", gitsigns.diffthis)
    set("n", "<Leader>gD", function()
      gitsigns.diffthis("~")
    end)
    set("n", "<Leader>td", gitsigns.toggle_deleted)

    -- Text object
    set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
