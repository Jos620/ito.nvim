local status, gpt = pcall(require, "chatgpt")

if not status then
  return
end

gpt.setup({
  api_key_cmd = "pass show openai/api/neovim",
})
