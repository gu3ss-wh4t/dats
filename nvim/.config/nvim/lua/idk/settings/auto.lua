-- & Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Yank highlight',
  group = vim.api.nvim_create_augroup('highlight-yank', {
    clear = true
  }),
  callback = function()
    vim.hl.on_yank()
  end
})

-- & Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      bufnr = args.buf
    })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")
  end
})
