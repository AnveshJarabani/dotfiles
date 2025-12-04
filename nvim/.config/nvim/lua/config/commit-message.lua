-- Commit message generation module
local M = {}

function M.generate_commit_message()
  local terminals = require("config.terminals")
  local copilot_term = terminals.get_copilot_term()
  
  -- Create prompt for commit message
  local prompt = 'add commit message with lots of fun fancy modern icons'
  
  -- Open terminal
  copilot_term:toggle()
  
  -- Wait a bit for terminal to be ready, then send the prompt
  vim.defer_fn(function()
    copilot_term:send(prompt)
  end, 500)
  
  vim.notify("🤖 Commit message prompt injected into Copilot terminal!", vim.log.levels.INFO)
end

return M
