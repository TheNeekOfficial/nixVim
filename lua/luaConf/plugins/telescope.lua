return {
  {
    "telescope.nvim",
    for_cat = 'general.telescope',
    cmd = { "Telescope" },
    on_require = { "telescope", },

    keys = {
      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>st", builtin.colorscheme, { desc = "[S]earch Color [T]hemes" })

      -- File browser setup
      local fb = require("telescope").extensions.file_browser
      vim.keymap.set("n", "<leader>fb", function()
      fb.file_browser({ path = "%:p:h" })
      end, { desc = "Telescope [F]ile [B]rowser" })
    },

    load = function (name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("telescope-fzf-native.nvim")
      vim.cmd.packadd("telescope-ui-select.nvim")
    end,

    -- NOTE: not sure if i need it
    after = function (plugin)
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
  }
}
