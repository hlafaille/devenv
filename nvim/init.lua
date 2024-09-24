vim.opt.number = true
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- Use spaces instead of tabs

-- keybinds
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', {})
vim.keymap.set({'n', 'i', 'v', 't'}, '<C-j>', '<cmd>ToggleTerm<cr>', { noremap = true, silent = true, desc = "Toggle terminal" })
vim.keymap.set({'n', 'i', 'v', 't'}, '<C-f>', '<cmd>BLines<cr>', { noremap = true, silent = true, desc = "Search Buffer"})

-- config imports
require("config.lazy")
require("config.treesitter")
require("config.cmp")
require("config.file_tree")
require("config.toggleterm")
require("config.indent-blankline")
