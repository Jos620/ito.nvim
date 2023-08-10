return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  event = "User FileOpened",
  lazy = true,
  config = function()
    local mason_status, mason = pcall(require, "mason")
    if not mason_status then
      return
    end

    mason.setup()
  end,
}
