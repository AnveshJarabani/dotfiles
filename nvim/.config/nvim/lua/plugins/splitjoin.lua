return {
  {
    "AndrewRadev/splitjoin.vim",
    event = "VeryLazy",
    config = function()
      vim.g.splitjoin_split_mapping = "gS"
      vim.g.splitjoin_join_mapping = "gJ"
    end,
  },
}
