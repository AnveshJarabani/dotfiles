-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure leader is set (LazyVim sets this, but being explicit)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Prevent space from moving cursor in normal mode (make it a noop)
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

vim.opt.swapfile = false
vim.opt.shortmess:append "A"
