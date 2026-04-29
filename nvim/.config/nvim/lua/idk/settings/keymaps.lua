local opts = {
  noremap = true,
  silent = true
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.laststatus = 0

-- & Splits, Tabs & Window Manipulations
-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", {
  desc = "Split window vertically"
})
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", {
  desc = "Split window horizontally"
})

-- Navigate between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts) -- Move to left window
vim.keymap.set('n', '<C-j>', '<C-w>j', opts) -- Move to below window
vim.keymap.set('n', '<C-k>', '<C-w>k', opts) -- Move to above window
vim.keymap.set('n', '<C-l>', '<C-w>l', opts) -- Move to right window

-- Move windows
vim.keymap.set('n', '<C-A-h>', '<C-w>H', opts) -- Move window left
vim.keymap.set('n', '<C-A-j>', '<C-w>J', opts) -- Move window below
vim.keymap.set('n', '<C-A-k>', '<C-w>K', opts) -- Move window above
vim.keymap.set('n', '<C-A-l>', '<C-w>L', opts) -- Move window right

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', opts) -- Increase height
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', opts) -- Decrease height
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts) -- Decrease width
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts) -- Increase width

-- & Some Basics
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>W', ':w<CR>', {
  desc = '[W]rite buffer'
})
vim.keymap.set('n', '<leader>wq', ':wq<CR>', {
  desc = '[W]rite & [Q]uit'
})
vim.keymap.set('n', '<leader>qq', ':q<CR>', {
  desc = '[Q]uit'
})
vim.keymap.set('n', '<leader>qa', ':quitall!<CR>', {
  desc = '[Q]uit [A]ll'
})
vim.keymap.set('n', '<leader>Q', ':q!<CR>', {
  desc = 'Force quit'
})
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', {
  desc = 'Source NVIM'
})
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {
  desc = 'Move line down in Visual Mode'
})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {
  desc = 'Move line up in Visual Mode'
})

-- & Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", {
  desc = "Indent left and reselect"
})
vim.keymap.set("v", ">", ">gv", {
  desc = "Indent right and reselect"
})

-- & Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", {
  desc = "Next search result (centered)"
})
vim.keymap.set("n", "N", "Nzzzv", {
  desc = "Previous search result (centered)"
})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {
  desc = "Half page down (centered)"
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {
  desc = "Half page up (centered)"
})

-- & Better J behavior
vim.keymap.set("n", "J", "mzJ`z", {
  desc = "Join lines and keep cursor position"
})
