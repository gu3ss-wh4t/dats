local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      {{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"}, {"\nPress any key to exit..."}}, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {{
    import = "idk.plugins"
  }},
  checker = {
    enabled = true,
    notify = false
  },
  change_detection = {
    enabled = true,
    notify = false
  }
})

-- & Colors to load after plugins
vim.api.nvim_set_hl(0, "Cursor", {
  bg = "#F67D31"
})
-- vim.api.nvim_set_hl(0, "LineNr", {
--   fg = "#F67D31",
--   bg = "#000000"
-- })
-- vim.api.nvim_set_hl(0, "LineNrAbove", {
--   fg = "#5478FF",
--   bg = "#000000"
-- })
-- vim.api.nvim_set_hl(0, "LineNrBelow", {
--   fg = "#5478FF",
--   bg = "#000000"
-- })
vim.api.nvim_set_hl(0, "SignColumn", {
  bg = "#000000"
})
vim.api.nvim_set_hl(0, "StatusLine", {
  fg = "#0de2c2"
})

-- & Buffers
-- vim.cmd [[highlight TabLine guibg=#000000]]
-- vim.cmd [[highlight TabLineSel guibg=#000000]]

-- & Visual mode highlight
vim.cmd [[highlight Visual guibg=#19003e]]
vim.cmd [[highlight VisualNOS guibg=#19003e]]

-- & Pmenu
vim.cmd [[highlight Pmenu guibg=#000000]]
vim.cmd [[highlight PmenuSel guibg=#19003e]]
vim.cmd [[highlight PmenuSbar guibg=#000000 guifg=#19003e]]

-- & Noice
vim.cmd [[highlight NoicePopupBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoiceConfirmBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoiceCmdlineBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoiceCmdlinePopupBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoicePopupmenu guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoicePopupmenuBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight NoiceCmdlinePopupBorderCmdline guibg=#000000 guifg=#F67D31]]
vim.cmd [[highlight NoiceCmdlinePopupTitleLua guibg=#000000 guifg=#F67D31]]

-- & Blink
vim.cmd [[highlight BlinkCmpMenuBorder guibg=#000000 guifg=#19003e]]
vim.cmd [[highlight BlinkCmpDocBorder guibg=#000000 guifg=#19003e]]

-- & WinBar
vim.cmd [[highlight WinBar cterm=italic gui=italic guibg=#000000 guifg=#5478FF]]
vim.cmd [[highlight WinBarNC cterm=italic guibg=#000000 guifg=#5478FF]]

-- & RenderMarkdown
-- * Headings
vim.cmd [[highlight RenderMarkdownH1Bg guibg=#000000 guifg=#5478FF]]
vim.cmd [[highlight RenderMarkdownH2Bg guibg=#000000 guifg=#FEEC37]]
vim.cmd [[highlight RenderMarkdownH3Bg guibg=#000000 guifg=#F67D31]]
vim.cmd [[highlight RenderMarkdownH4Bg guibg=#000000 guifg=#0de2c2]]
vim.cmd [[highlight RenderMarkdownH5Bg guibg=#000000 guifg=#3600aa]]
vim.cmd [[highlight RenderMarkdownH6Bg guibg=#000000 guifg=#3600aa]]
-- * Signs
vim.cmd [[highlight RenderMarkdownH1 guifg=#5478FF]]
vim.cmd [[highlight RenderMarkdownH2 guifg=#FEEC37]]
vim.cmd [[highlight RenderMarkdownH3 guifg=#F67D31]]
vim.cmd [[highlight RenderMarkdownH4 guifg=#0de2c2]]
vim.cmd [[highlight RenderMarkdownH5 guifg=#3600aa]]
vim.cmd [[highlight RenderMarkdownH6 guifg=#3600aa]]
