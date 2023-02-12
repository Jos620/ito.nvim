local status, copilot = pcall(require, "copilot")
if not status then
  return
end

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
  },
})

local status_cmp, copilot_cmp = pcall(require, "copilot_cmp")
if not status_cmp then
  return
end

copilot_cmp.setup()
