local utils = require("jos620.utils")

return {
  { -- Telescope
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "ThePrimeagen/harpoon",
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local telescope_keymaps = {
        ["<C-x>"] = false,
        ["<C-v>"] = actions.select_vertical,
        ["<C-b>"] = actions.select_horizontal,
      }

      telescope.setup({
        defaults = {
          mappings = {
            i = telescope_keymaps,
            n = utils.MergeTables({
              telescope_keymaps,
              {
                ["q"] = actions.close,
              },
            }),
          },
          layout_strategy = "horizontal",
          winblend = 0,
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            "package-lock.json",
            "pnpm-lock.yaml",
            "\\.git",
            ".cache",
            ".DS_Store",
          },
        },
      })

      utils.SetKeymap("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
      utils.SetKeymap("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
      utils.SetKeymap("n", "<Leader>fh", ":Telescope highlights<Return>", "Find highlights")
      utils.SetKeymap("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
      utils.SetKeymap("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
      utils.SetKeymap("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
      utils.SetKeymap("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")

      local fzf_status = pcall(require, "telescope._extensions.fzf")
      if fzf_status and vim.fn.executable("fzf") == 1 then
        telescope.load_extension("fzf")
      end

      local harpoon_status = pcall(require, "telescope._extensions.harpoon")
      if harpoon_status then
        telescope.load_extension("harpoon")
      end
    end,
  },

  { -- fzf
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
    cond = function()
      return utils.CheckDependencies({ "fzf", "make" })
    end,
  },

  { -- Hardpoon
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      utils.SetKeymap("n", "|", function()
        mark.add_file()
        ui.toggle_quick_menu()
      end, "Add file to harpoon")

      utils.SetKeymap("n", "<Leader>|", ui.toggle_quick_menu, "Toggle harpoon menu")

      for i = 1, 9 do
        utils.SetKeymap("n", "\\" .. tostring(i), function()
          ui.nav_file(i)
        end, "Go to harpoon mark " .. i)
      end

      utils.SetKeymap("n", "\\<Tab>", function()
        local last_file_path = utils.GetFilePathByMark("0")
        if last_file_path == nil then
          return
        end

        local is_home = vim.fn.expand("%:p:h") == vim.fn.expand("$HOME")
        local is_git_file = string.find(last_file_path, ".git")
        local is_folder = utils.IsDirectory(last_file_path)
        local file_exists = vim.fn.filereadable(last_file_path) == 1
        local is_inside_working_directory = utils.FileIsInWorkingDirectory(last_file_path)

        if is_home or is_git_file or is_folder or not file_exists or not is_inside_working_directory then
          return
        end

        vim.cmd("normal! '0")
        utils.CloseEmptyBuffers()
      end, "Go to last opened file")

      utils.CreateCommand("Harpoon", "require('harpoon.ui').toggle_quick_menu()")
      utils.CreateCommand("HarpoonAdd", "require('harpoon.mark').add_file()")

      local colors = utils.GetCurrentThemeColors()

      utils.LinkHighlightGroups("harpoonwindow", "Normal")
      utils.SetHighlight("HarpoonBorder", { fg = colors.green })
    end,
  },
}
