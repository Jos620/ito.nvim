return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  cmd = "Telescope",
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
    local telescope_status, telescope = pcall(require, "telescope")
    if not telescope_status then
      return
    end

    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    local keymaps = {
      ["<C-x>"] = false,
      ["<C-v>"] = actions.select_vertical,
      ["<C-b>"] = actions.select_horizontal,
    }

    telescope.setup({
      defaults = {
        mappings = {
          i = keymaps,
          n = keymaps,
        },
        -- layout_config = {
        --   preview_width = 0.5,
        -- },
        -- wrap_results = true,
        layout_strategy = "horizontal",
        -- sorting_strategy = "ascending",
        winblend = 0,
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

    local fzf_status = pcall(require, "telescope._extensions.fzf")
    if fzf_status and vim.fn.executable("fzf") == 1 then
      telescope.load_extension("fzf")
    end

    local harpoon_status = pcall(require, "telescope._extensions.harpoon")
    if harpoon_status then
      telescope.load_extension("harpoon")
    end

    local file_browser_status = pcall(require, "telescope._extensions.file_browser")
    if file_browser_status then
      telescope.load_extension("file_browser")
    end
  end,
}
