return {
  -- Add the plugin to your config
  "nvim-telescope/telescope-ui-select.nvim",

  config = function()
    require("telescope").load_extension("ui-select")
  end,
}
