-- .config/nvim/lua/plugins/init.lua
-- ...
return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Load when LSP attaches
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        -- Style preset for diagnostic messages
        -- Available options:
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = "simple",
      })
    end,
  },
}
