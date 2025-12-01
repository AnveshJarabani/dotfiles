return {
  "ryanmsnyder/toggleterm-manager.nvim",
  dependencies = {
    "akinsho/nvim-toggleterm.lua",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("toggleterm_manager")
  end,
}