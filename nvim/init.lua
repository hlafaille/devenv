vim.opt.number = true
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- Use spaces instead of tabs

-- keybinds
local modes = {'n', 'i', 'v', 't'}

vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', {})
vim.keymap.set(modes, '<C-j>', '<cmd>ToggleTerm<cr>', { noremap = true, silent = true, desc = "Toggle terminal" })
vim.keymap.set(modes, '<C-f>', '<cmd>BLines<cr>', { noremap = true, silent = true, desc = "Search Buffer"})
vim.keymap.set(modes, '<C-Tab>', '<cmd>bnext<cr>', { noremap = true, silent = true, desc = "Next Buffer"})
vim.keymap.set(modes, '<C-s>', '<cmd>w<cr>', { noremap = true, silent = true, desc = "Write buffer"})
vim.keymap.set(modes, '<C-w>', '<cmd>bd<cr>', { noremap = true, silent = true, desc = "Close Buffer"})
vim.keymap.set(modes, '<C-S-f>', '<cmd>Rg<cr>', { noremap = true, silent = true, desc = "Full project search"})

-- config imports
require("config.lazy")
require("config.treesitter")
require("config.cmp")
require("config.file_tree")
require("config.toggleterm")
require("config.indent-blankline")
