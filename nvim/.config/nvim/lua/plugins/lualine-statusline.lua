-- Set lualine as statusline
return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    -- Custom session name component for auto-session
    local function session_name()
      local cwd = vim.loop.cwd()
      if cwd == vim.loop.os_homedir() then
        return ""
      end
      return vim.fn.fnamemodify(cwd, ":t")
    end
    if not vim.g.trouble_lualine then
      table.insert(opts.sections.lualine_c, { "navic", color_correction = "dynamic" })
    end

    -- Deep, vibrant colors for all segments and modes
    local colors = {
      normal = "#98c379", -- green
      insert = "#61afef", -- blue
      visual = "#c678dd", -- purple
      replace = "#e06c75", -- red
      command = "#e5c07b", -- yellow
      terminal = "#56b6c2", -- cyan
      inactive = "#3e4452", -- gray
      bg = "#282c34",
      fg = "#abb2bf",
    }

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      icons_enabled = true,
      theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.normal, gui = "bold" },
          b = { fg = colors.fg, bg = "#3e4452" },
          c = { fg = colors.fg, bg = "#2c323c" },
        },
        insert = { a = { fg = colors.bg, bg = colors.insert, gui = "bold" } },
        visual = { a = { fg = colors.bg, bg = colors.visual, gui = "bold" } },
        replace = { a = { fg = colors.bg, bg = colors.replace, gui = "bold" } },
        command = { a = { fg = colors.bg, bg = colors.command, gui = "bold" } },
        terminal = { a = { fg = colors.bg, bg = colors.terminal, gui = "bold" } },
        inactive = {
          a = { fg = colors.fg, bg = colors.inactive, gui = "bold" },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = "#2c323c" },
        },
      },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "neo-tree", "Avante" },
      always_divide_middle = true,
    })

    -- Bottom statusline
    require("lualine").setup(opts)

    -- Top statusline using winbar (Neovim 0.8+)
    require("lualine").setup(vim.tbl_deep_extend("force", opts, {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = false,
        disabled_filetypes = { "alpha", "neo-tree", "Avante" },
        always_divide_middle = true,
        theme = opts.options.theme,
        icons_enabled = true,
      },
      sections = {
        lualine_b = { "diagnostics" },
      },
      winbar = {
        lualine_a = {
          {
            function()
              return ""
            end,
            color = { fg = "#6d6fc2", gui = "bold" },
          },
        },
        lualine_b = {
          { "navic", color_correction = "dynamic", color = { fg = "#61afef", bg = "#232634" } },
          { "filename", path = 3, color = { fg = "#e5c07b", bg = "#232634" } },
        },
        lualine_c = { "filetype" },
        lualine_y = { "lsp_status" },
        lualine_z = {
          {
            function()
              local session = require("auto-session.lib").current_session_name(true)
              if session ~= "" then
                return "󱂬 " .. session
              end
              return ""
            end,
            color = { fg = "#1a1b26", bg = "#6d6fc2", gui = "bold" },
            section_separators = { left = "", right = "" },
            padding = { left = 1, right = 1 },
          },
        },
      },
      inactive_winbar = {},
      extensions = { "quickfix", "neo-tree", "fugitive", "lazy", "mason", "aerial", "toggleterm", "trouble" },
    }))
  end,
}
