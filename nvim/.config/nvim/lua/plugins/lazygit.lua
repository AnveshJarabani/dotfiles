return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      -- Configure lazygit to use custom config file (set before plugin loads)
      vim.g.lazygit_use_custom_config_file_path = 1
      vim.g.lazygit_config_file_path = "/root/lazygit/themes-mergable/macchiato/maroon.yml"
    end,
  },
}
