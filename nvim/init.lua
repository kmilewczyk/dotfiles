require('plugins')

local opt = vim.opt
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.number = true

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
  augroup END
]])

