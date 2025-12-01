return {
  "nvim-telescope/telescope-media-files.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").setup({
      extensions = {
        media_files = {
          filetypes = { "png", "webp", "jpg", "jpeg" },
          find_cmd = "find",
        },
      },
    })
    require("telescope").load_extension("media_files")
  end,
}