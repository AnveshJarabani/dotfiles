-- Disable diagnostics and linters for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = function()
    vim.diagnostic.disable(0)
    -- Disable LSP diagnostics for markdown
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
        underline = false,
        update_in_insert = false,
      }
    )
  end,
})

-- Disable markdownlint globally via autocommand
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = { "*.md", "*.markdown" },
  callback = function()
    vim.b.disable_autoformat = true
  end,
})
