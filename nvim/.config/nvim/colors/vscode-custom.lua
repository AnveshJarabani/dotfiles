-- Custom VS Code inspired colorscheme
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "vscode-custom"

local colors = {
  bg = "#010409",
  fg = "#6ae5a4",
  green = "#81fa00",
  bright_green = "#00ff04",
  yellow = "#eeff00",
  orange = "#ffa200",
  pink = "#f553a7",
  purple = "#cf0eff",
  cyan = "#00fff7",
  blue = "#00bbff",
  red = "#fbff00",
  line_highlight = "#5d1d6045",
  cursor = "#f145d7",
  selection = "#ffc800",
  comment = "#a7a7a7",
  string = "#ecf400d5",
  number = "#ff9d00",
}

local highlights = {
  -- Base
  Normal = { fg = colors.fg, bg = colors.bg },
  NormalFloat = { fg = colors.fg, bg = colors.bg },

  -- Cursor and lines
  Cursor = { fg = colors.cursor },
  CursorLine = { bg = colors.line_highlight },
  LineNr = { fg = "#3cff0095" },
  CursorLineNr = { fg = "#d9ff00" },

  -- Selection
  Visual = { bg = colors.selection },

  -- Syntax
  Comment = { fg = colors.comment, italic = true },
  String = { fg = colors.string, italic = true, bold = true },
  Number = { fg = colors.number },
  Float = { fg = colors.number },
  Function = { fg = "#aff522cd" },
  Keyword = { fg = colors.orange, bold = true },
  Conditional = { fg = colors.pink, italic = true, bold = true },
  Repeat = { fg = colors.pink, italic = true, bold = true },
  Variable = { fg = colors.blue },
  Constant = { fg = colors.purple },
  Identifier = { fg = colors.blue },
  Type = { fg = colors.green },

  -- Treesitter
  ["@comment"] = { fg = colors.comment, italic = true },
  ["@string"] = { fg = colors.string, italic = true, bold = true },
  ["@number"] = { fg = colors.number },
  ["@function"] = { fg = "#aff522cd" },
  ["@keyword"] = { fg = colors.orange, bold = true },
  ["@keyword.function"] = { fg = colors.pink, italic = true, bold = true },
  ["@keyword.conditional"] = { fg = colors.pink, italic = true, bold = true },
  ["@variable"] = { fg = colors.blue },
  ["@constant"] = { fg = colors.purple },
  ["@punctuation"] = { fg = colors.bright_green },
  ["@operator"] = { fg = colors.pink },

  -- UI
  StatusLine = { fg = colors.green, bg = colors.bg },
  StatusLineNC = { fg = "#81fa00a2", bg = colors.bg },
  TabLine = { fg = "#ffff00b2", bg = colors.bg },
  TabLineFill = { bg = colors.bg },
  TabLineSel = { fg = colors.green, bg = colors.bg },

  -- Diagnostics
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.yellow },
  DiagnosticInfo = { fg = colors.cyan },
  DiagnosticHint = { fg = colors.green },
}

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end
