-- Git branch picker with create option
local M = {}

function M.pick_branch()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map_key)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      -- Override the default select action
      map_key("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local input_text = current_picker:_get_prompt()
        
        actions.close(prompt_bufnr)
        
        if selection then
          -- Branch exists, checkout
          vim.cmd("Git checkout " .. selection.value)
        elseif input_text and input_text ~= "" then
          -- No selection but text entered, create new branch
          vim.ui.input({
            prompt = "Create new branch '" .. input_text .. "'? (y/n): ",
          }, function(confirm)
            if confirm and confirm:lower() == "y" then
              vim.cmd("Git checkout -b " .. input_text)
              vim.notify("Created and switched to new branch: " .. input_text, vim.log.levels.INFO)
            end
          end)
        end
      end)
      
      return true
    end,
  })
end

return M
