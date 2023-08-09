return {
  "2nthony/vitesse.nvim",
  dependencies = {
    "tjdevries/colorbuddy.vim",
  },
  config = function()
    local status, vitesse = pcall(require, "vitesse")

    if not status then
      return
    end

    vitesse.setup({
      comment_italics = false,
      float_background = true,
      reverse_visual = true,
    })

    vim.cmd("colorscheme vitesse")
  end,
}
