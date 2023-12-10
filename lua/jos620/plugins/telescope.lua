local utils = require("jos620.utils")
local keymaps = require("jos620.core.keymaps")

return {
  { -- Telescope
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "ThePrimeagen/harpoon",
    },
    event = "VeryLazy",
    keys = {
      {
        "<Leader>F",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = {
              height = 40,
            },
          })
        end,
      },
    },
    config = function()
      local telescope = require("telescope")

      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

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
          -- layout_config = {
          --   preview_width = 0.5,
          -- },
          -- wrap_results = true,
          layout_strategy = "horizontal",
          -- sorting_strategy = "ascending",
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
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            wrap_results = true,
            mappings = {
              ["n"] = {
                ["a"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["dd"] = fb_actions.remove,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
                ["<C-u>"] = function(bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_previous(bufnr)
                  end
                end,
                ["<C-d>"] = function(bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_next(bufnr)
                  end
                end,
                ["<PageUp>"] = actions.preview_scrolling_up,
                ["<PageDown8>"] = actions.preview_scrolling_down,
              },
            },
          },
        },
      })

      keymaps.set("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
      keymaps.set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
      keymaps.set("n", "<Leader>fh", ":Telescope highlights<Return>", "Find highlights")
      keymaps.set("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
      keymaps.set("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
      keymaps.set("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
      keymaps.set("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")

      local fzf_status = pcall(require, "telescope._extensions.fzf")
      if fzf_status and vim.fn.executable("fzf") == 1 then
        telescope.load_extension("fzf")
      end

      local file_browser_status = pcall(require, "telescope._extensions.file_browser")
      if file_browser_status then
        telescope.load_extension("file_browser")
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
    event = "VeryLazy",
    keys = {
      "<Leader>",
    },
    config = function()
      local harpoon_status, _ = pcall(require, "harpoon")
      if not harpoon_status then
        return
      end

      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      keymaps.set("n", "<Leader>\\", function()
        mark.add_file()
        ui.toggle_quick_menu()
      end, "Add file to harpoon")

      keymaps.set("n", "<Leader>|", ui.toggle_quick_menu, "Toggle harpoon menu")

      for i = 1, 9 do
        keymaps.set("n", "<Leader>" .. tostring(i), function()
          ui.nav_file(i)
        end, "Go to harpoon mark " .. i)
      end
    end,
  },
}
