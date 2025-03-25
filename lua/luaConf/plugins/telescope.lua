return {
  {
    "telescope.nvim",
    for_cat = 'general.telescope',
    cmd = { "Telescope" },
    on_require = { "telescope", },

    keys = {
      -- See `:help telescope.builtin`
      { "<leader>sh", function() require("telescope.builtin").help_tags() end, mode = { "n" }, desc = "[S]earch [H]elp" },
      { "<leader>sk", function() require("telescope.builtin").keymaps() end, mode = { "n" }, desc = "[S]earch [K]eymaps" },
      { "<leader>sf", function() require("telescope.builtin").find_files() end, mode = { "n" }, desc = "[S]earch [F]iles" },
      { "<leader>ss", function() require("telescope.builtin").builtin() end, mode = { "n" }, desc = "[S]earch [S]elect Telescope" },
      { "<leader>sw", function() require("telescope.builtin").grep_string() end, mode = { "n" }, desc = "[S]earch current [W]ord" },
      { "<leader>sg", function() require("telescope.builtin").live_grep() end, mode = { "n" }, desc = "[S]earch by [G]rep" },
      { "<leader>sd", function() require("telescope.builtin").diagnostics() end, mode = { "n" }, desc = "[S]earch [D]iagnostics" },
      { "<leader>sr", function() require("telescope.builtin").resume() end, mode = { "n" }, desc = "[S]earch [R]esume" },
      { "<leader>s.", function() require("telescope.builtin").oldfiles() end, mode = { "n" }, desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader><leader>", function() require("telescope.builtin").buffers() end, mode = { "n" }, desc = "[ ] Find existing buffers" },
      { "<leader>st", function() require("telescope.builtin").colorscheme() end, mode = { "n" }, desc = "[S]earch Color [T]hemes" },

      -- File browser setup
      { "<leader>fb", function()
      require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" })
      end, mode = { 'n' }, desc = "Telescope [F]ile [B]rowser" },
    },

    load = function (name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("telescope-fzf-native.nvim")
      vim.cmd.packadd("telescope-ui-select.nvim")
    end,

    after = function(plugin)
      require("telescope").setup({
        extensions = {
          ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
          file_browser = {
         require("telescope.themes").get_dropdown(),
         hijack_netrw = true,
          }
        }
      })
      pcall(require("telescope").load_extension, "file_browser")
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  }
}
