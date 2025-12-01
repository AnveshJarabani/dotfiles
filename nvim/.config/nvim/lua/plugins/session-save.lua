return {
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true,
        picker_opts = {
          layout_strategy = "center",
          layout_config = {
            width = 0.6,
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 1,
            -- Do NOT set preview_width here!
          },
          preview = false,
        },
      },
      notify = false,
    },
    config = function()
      require("auto-session").setup({
        auto_restore_last_session = vim.fn.argc() == 0,
        auto_create = function()
          local cmd = "git rev-parse --is-inside-work-tree"
          return vim.fn.system(cmd) == "true\n"
        end,
      })
    end,
  },
}
