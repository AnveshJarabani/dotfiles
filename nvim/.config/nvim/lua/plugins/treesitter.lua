return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "vim",
      "regex",
      "lua",
      "bash",
      "markdown",
      "markdown_inline",
    },
    highlight = { enable = true },
  },
}
