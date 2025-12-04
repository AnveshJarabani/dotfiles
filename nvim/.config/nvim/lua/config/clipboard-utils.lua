-- Clipboard and path utilities module
local M = {}

function M.copy_buffer_directory()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify("Copied directory to clipboard:\n" .. dir, vim.log.levels.INFO)
end

function M.copy_buffer_filepath()
  local path = vim.fn.expand("%:p:r")
  vim.fn.setreg("+", path)
  vim.notify("Copied file path to clipboard:\n" .. path, vim.log.levels.INFO)
end

function M.copy_windows_path()
  local filepath = vim.fn.expand("%:p")
  local win_path = vim.fn.system("wslpath -w " .. vim.fn.shellescape(filepath)):gsub("\n", "")
  vim.fn.setreg("+", win_path)
  vim.notify("Copied Windows path to clipboard:\n" .. win_path, vim.log.levels.INFO)
end

function M.open_in_one_commander()
  local filepath = vim.fn.expand("%:p")
  local win_path = vim.fn.system("wslpath -w " .. vim.fn.shellescape(filepath)):gsub("\n", "")
  vim.fn.system("/mnt/c/Program\\ Files/OneCommander/OneCommander.exe " .. vim.fn.shellescape(win_path))
  vim.notify("Opened in One Commander:\n" .. win_path, vim.log.levels.INFO)
end

function M.copy_filename()
  local filename = vim.fn.expand("%:t:r")
  vim.fn.setreg("+", filename)
  vim.notify("Copied file name to clipboard:\n" .. filename, vim.log.levels.INFO)
end

function M.copy_relative_path()
  local cwd = vim.fn.getcwd()
  local filepath = vim.fn.expand("%:p")
  local relative_path = vim.fn.fnamemodify(filepath, ":.")
  relative_path = "./" .. relative_path
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied project-relative path to clipboard:\n" .. relative_path, vim.log.levels.INFO)
end

function M.open_in_vscode()
  local cwd = vim.fn.getcwd()
  vim.fn.system("code " .. vim.fn.shellescape(cwd))
  vim.notify("Opened project in VS Code: " .. cwd, vim.log.levels.INFO)
end

return M
