return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    local status, copilot = pcall(require, "copilot")
    if not status then
      return
    end

    copilot.setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      filetypes = {
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
        ["*"] = true,
      },
    })

    local status_cmp, copilot_cmp = pcall(require, "copilot_cmp")
    if not status_cmp then
      return
    end

    copilot_cmp.setup()
  end,
}
