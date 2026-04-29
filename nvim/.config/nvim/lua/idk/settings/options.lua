vim.cmd('let g:netrw_banner = 0')

-- & System clipboard
-- ? Via explicit tooling
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*')
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*')
--   }
-- }

-- ? Don't know, y the fuck it happens to be so simple..
--[[
Check later, how is it so, that u find this .schedule(func)
in some random youtube video instead of official docs...
Love spending lots of hours trying to configure this fucking
clipboard!
I love tech🖤!!!
]]

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- &Editor
vim.o.showmode = false
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣'
}
vim.o.inccommand = 'split'
vim.o.mouse = 'a'
vim.g.have_nerd_font = true
vim.opt.winborder = "rounded"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.termguicolors = true -- colors support
vim.opt.background = 'dark'
vim.opt.scrolloff = 15
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '74' -- Just smth about a half of my screen
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.spelllang = {'en', 'es', 'fr', 'ru'}
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Keep all folds open by default

-- &Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.o.breakindent = true

-- &File Management
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't backup before overwriting
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.updatetime = 250 -- Time in ms to trigger CursorHold
vim.opt.timeoutlen = 300 -- Time in ms to wait for mapped sequence
vim.opt.ttimeoutlen = 0 -- No wait for key code sequences
vim.opt.autoread = true -- Auto-reload file if changed outside
vim.opt.autowrite = false -- Don't auto-save on some events
vim.opt.diffopt:append("vertical") -- Vertical diff splits
vim.opt.diffopt:append("algorithm:patience") -- Better diff algorithm
vim.opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)

-- &Set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end

-- &Search
vim.opt.incsearch = true -- realtime search
vim.opt.hlsearch = true -- search highlighting
vim.opt.inccommand = 'split' -- substitution command preview
vim.opt.ignorecase = true -- insensitive search
vim.opt.smartcase = true -- enchanced sensitive search
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'

-- &Misc
vim.opt.updatetime = 50
vim.g.editorconig = true
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Show markup even on cursor line
vim.opt.lazyredraw = false -- redraw while executing macros (butter UX)
vim.opt.redrawtime = 10000 -- Timeout for syntax highlighting redraw
vim.opt.maxmempattern = 20000 -- Max memory for pattern matching
vim.opt.synmaxcol = 300 -- Syntax highlighting column limit
vim.opt.errorbells = false -- Disable error sounds
vim.opt.backspace = "indent,eol,start" -- Make backspace behave naturally
vim.opt.autochdir = false -- Don't change directory automatically
vim.opt.iskeyword:append("-") -- Treat dash as part of a word
vim.opt.path:append("**") -- Search into subfolders with `gf`
vim.opt.selection = "inclusive" -- Use inclusive selection
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.modifiable = true -- Allow editing buffers
vim.opt.encoding = "UTF-8" -- Use UTF-8 encoding
vim.opt.wildmenu = true -- Enable command-line completion menu
vim.opt.wildmode = "longest:full,full" -- Completion mode for command-line
vim.opt.wildignorecase = true -- Case-insensitive tab completion in commands

-- &Cursor
vim.opt.guicursor = {"n-v:block10", -- Normal, Visual
"i-c-ci-ve:hor10", -- Insert, Command-line, Command-line Insert, Visual-exclusive
"r-cr:ver10", -- Replace, Command-line Replace
"o:hor20", -- Operator-pending
"i-c-ci-ve:blinkwait900-blinkoff500-blinkon300-Cursor/lCursor", -- All modes: blinking & highlight groups
"sm:block-blinkwait175-blinkoff150-blinkon175" -- Showmatch mode
}
