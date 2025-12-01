return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    -- no specific config needed, the plugin works out of the box with default keybindings
    -- but we can add the keymappings explicitly for clarity
    vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
    vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
    vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
    vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
    vim.keymap.set("n", "<C-\">", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })
  end,
}