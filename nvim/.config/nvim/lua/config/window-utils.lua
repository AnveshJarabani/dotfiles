-- Window and UI utilities module
local M = {}

function M.close_floating_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

function M.remove_trailing_whitespace()
  vim.cmd([[%s/\s\+$//e]])
  print("Removed trailing whitespace from current buffer")
end

return M
