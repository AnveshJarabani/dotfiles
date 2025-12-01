-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  opts = {},
  config = function()
    -- vim.lsp.inlay_hint.enable(false)
    vim.diagnostic.config({
      -- virtual_text = { current_line = true },
      virtual_text = false, -- Disable virtual text if you want to use inline diagnostics
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
      },
    })
  end,
}
