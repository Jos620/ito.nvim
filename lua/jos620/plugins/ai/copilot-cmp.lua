return {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  config = function()
    local status, copilot_cmp = pcall(require, "copilot_cmp")
    if not status then
      return
    end

    copilot_cmp.setup()
  end,
}
