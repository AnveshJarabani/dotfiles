return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = false,
      },
      commands = {
        all = {
          view = "popup",
        },
        history = {
          view = "popup",
        },
      },
      notify = {
        max = 1, -- only show one notification at a time
        view = "mini",
        timeout = 500, -- show notifications for .5 second
        opts = { border = { highlight = "FloatBorder:DiffAdded" } }, -- green border for normal messages
      },
      lsp = {
        message = {
          enabled = true,
          view = "mini",
          max = 1,
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "40%",
            col = "50%",
          },
          border = {
            style = "rounded",
          },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
      },
    },
  },
}
