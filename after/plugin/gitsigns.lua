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

    local silent = { silent = true }

    -- Navigation
    set("n", "<Leader>gj", function()
      if vim.wo.diff then
        return "<Leader>gj"
      end

      vim.schedule(function()
        gitsigns.next_hunk()
      end)

      return "<Ignore>"
    end, { silent = true, expr = true })

    set("n", "<Leader>gk", function()
      if vim.wo.diff then
        return "<Leader>gk"
      end

      vim.schedule(function()
        gitsigns.prev_hunk()
      end)

      return "<Ignore>"
    end, { silent = true, expr = true })

    -- Actions
    set({ "n", "v" }, "<Leader>gr", ":Gitsigns reset_hunk<CR>", silent)
    set("n", "<Leader>gS", gitsigns.stage_buffer, silent)
    set("n", "<Leader>gu", gitsigns.undo_stage_hunk, silent)
    set("n", "<Leader>gR", gitsigns.reset_buffer, silent)
    set("n", "<Leader>gp", gitsigns.preview_hunk, silent)
    set("n", "<Leader>gl", function()
      gitsigns.blame_line({ full = true })
    end)
    set("n", "<Leader>gb", gitsigns.toggle_current_line_blame, silent)
    set("n", "<Leader>gd", gitsigns.diffthis, silent)
    set("n", "<Leader>gD", function()
      gitsigns.diffthis("~")
    end, silent)
    set("n", "<Leader>td", gitsigns.toggle_deleted, silent)

    -- Text object
    set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", silent)
  end,
})
