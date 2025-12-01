-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.markdown-diagnostics")
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.opt.fileformat = "unix"
  end,
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.fn.system("source ~/.zshrc")
    vim.cmd("startinsert")
  end,
})
vim.o.completeopt = "menu,menuone,noselect,noinsert,popup"
--keep active line always centered
vim.opt.scrolloff = 999
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Remove all \r from the current buffer before saving
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
      lines[i] = line:gsub("\r", "")
    end
    if vim.api.nvim_buf_get_option(0, "modifiable") then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "help",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd T") -- move help to a new tab
    end
  end,
})
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Dashboard")
    end
  end,
})
-- Buffer Management
vim.cmd("cabbr bd Bdelete") -- Use 'bdelete' plugin for safe buffer deletion
vim.cmd("cabbr bn bnext")
vim.cmd("cabbr bp bprevious")

-- Telescope abbreviations
vim.cmd("cabbr ff Telescope find_files")
vim.cmd("cabbr fg Telescope live_grep")
vim.cmd("cabbr fb Telescope buffers")
vim.cmd("cabbr fh Telescope help_tags")
vim.cmd("cabbr sl SessionSearch")
-- Lazy.nvim (Plugin Manager) abbreviations
vim.cmd("cabbr lx LazyExtras")
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#004400", fg = "#00ff00", bold = true })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4d1a1a", fg = "#ff0000", bold = true })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1f1a0d", fg = "#a8b3cf" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#004400", fg = "#00ff00", bold = true })
