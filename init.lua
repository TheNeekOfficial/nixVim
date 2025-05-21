-- NOTE: General setup stuff

-- Sets leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Asks nix if we have a nerd font
vim.g.have_nerd_font = nixCats("have_nerd_font")

-- Shows line number and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Save undo history
vim.opt.undofile = true

-- Case unsensitive for searching until a capital is typed
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how nvim will show certain whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Min no. of lines above and below cursor
vim.opt.scrolloff = 10

-- NOTE: Keymaps

-- For different windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


require('luaConf')
