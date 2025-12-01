return {
  {
    "magal1337/dataform.nvim",
    requires = {
      -- Optional dependencies
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("dataform").setup({
        -- refresh dataform metadata on each save
        compile_on_save = false,
      })
    end,
  },
}
