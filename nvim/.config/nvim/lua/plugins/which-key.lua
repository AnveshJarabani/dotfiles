return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- preset = "modern",
      delay = 100, -- Show popup quickly (ms after pressing leader)
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
