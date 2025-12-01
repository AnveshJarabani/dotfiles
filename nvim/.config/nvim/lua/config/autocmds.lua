-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Fix background color consistency after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local bg = "#1a1a1a"
    local highlights = {
      Normal = { bg = bg },
      NormalFloat = { bg = bg },
      NormalNC = { bg = bg },
      FloatBorder = { bg = bg, fg = "#4a4a4a" },
      SignColumn = { bg = bg },
      LineNr = { bg = bg },
      Pmenu = { bg = bg },
      PmenuSel = { bg = "#2d2d2d" },
      PmenuSbar = { bg = bg },
      PmenuThumb = { bg = "#3a3a3a" },
      WinSeparator = { fg = "#3a3a3a", bg = bg },
      VertSplit = { fg = "#3a3a3a", bg = bg },
      StatusLine = { bg = bg },
      StatusLineNC = { bg = bg },
      TabLine = { bg = bg },
      TabLineFill = { bg = bg },
      TabLineSel = { bg = "#2d2d2d" },
      EndOfBuffer = { bg = bg },
    }
    
    for group, colors in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, colors)
    end
  end,
})
