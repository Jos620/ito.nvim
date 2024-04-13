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
            n = utils.merge_tables({
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
            "lotties",
          },
        },
      })

      utils.set_keymap("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
      utils.set_keymap("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
      utils.set_keymap("n", "<Leader>fh", ":Telescope highlights<Return>", "Find highlights")
      utils.set_keymap("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
      utils.set_keymap("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
      utils.set_keymap("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
      utils.set_keymap("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")

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
      return utils.check_dependencies({ "fzf", "make" })
    end,
  },

  { -- Hardpoon
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      utils.set_keymap("n", "|", function()
        mark.add_file()
        ui.toggle_quick_menu()
      end, "Add file to harpoon")

      utils.set_keymap("n", "<Leader>|", ui.toggle_quick_menu, "Toggle harpoon menu")

      for i = 1, 9 do
        utils.set_keymap("n", "\\" .. tostring(i), function()
          ui.nav_file(i)
        end, "Go to harpoon mark " .. i)
      end

      utils.set_keymap("n", "\\<Tab>", function()
        local last_file_path = utils.get_file_path_by_mark("0")
        if last_file_path == nil then
          return
        end

        local is_home = vim.fn.expand("%:p:h") == vim.fn.expand("$HOME")
        local is_git_file = string.find(last_file_path, ".git")
        local is_folder = utils.is_directory(last_file_path)
        local file_exists = vim.fn.filereadable(last_file_path) == 1
        local is_inside_working_directory = utils.file_is_in_working_directory(last_file_path)

        if is_home or is_git_file or is_folder or not file_exists or not is_inside_working_directory then
          return
        end

        vim.cmd("normal! '0")
      end, "Go to last opened file")

      local colors = utils.get_current_theme_colors()

      utils.link_highlight_groups("harpoonwindow", "Normal")
      utils.set_highlight("HarpoonBorder", { fg = colors.green })
    end,
  },
}
