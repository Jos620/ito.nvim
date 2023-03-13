local status, flutter_tools = pcall(require, "flutter-tools")
if not status then
  return
end

flutter_tools.setup({})
