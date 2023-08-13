return {
  "rhysd/git-messenger.vim",
  cmd = "GitMessenger",
  config = function()
    vim.g.git_messenger_no_default_mappings = true
    vim.g.git_messenger_always_into_popup = true
    vim.g.git_messenger_floating_win_opts = {
      border = "rounded",
    }
  end,
}
