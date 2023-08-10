return {
  "numToStr/Comment.nvim",
  event = "BufRead",
  config = function()
    local status, comment = pcall(require, "Comment")
    if not status then
      return
    end

    comment.setup()
  end,
}
