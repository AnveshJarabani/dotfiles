-- Git branch picker with create option
local M = {}

function M.pick_branch()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Get local git branches only (excludes remote branches)
  local handle = io.popen("git branch --format='%(refname:short)'")
  local result = handle:read("*a")
  handle:close()

  local branches = {}
  for branch in result:gmatch("[^\r\n]+") do
    table.insert(branches, branch)
  end

  pickers
    .new({}, {
      prompt_title = "Git Branches (type to create new)",
      finder = finders.new_table({
        results = branches,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          local picker = action_state.get_current_picker(prompt_bufnr)
          local input_text = picker:_get_prompt()

          actions.close(prompt_bufnr)

          if selection then
            -- Branch exists, checkout
            local branch = selection[1]
            vim.fn.system("git checkout " .. vim.fn.shellescape(branch))
            vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
          elseif input_text and input_text ~= "" then
            -- No selection, create new branch
            vim.ui.input({
              prompt = "Create new branch '" .. input_text .. "'? (y/n): ",
              default = "y",
            }, function(confirm)
              if confirm and (confirm:lower() == "y" or confirm == "") then
                vim.fn.system("git checkout -b " .. vim.fn.shellescape(input_text))
                vim.notify("Created and switched to new branch: " .. input_text, vim.log.levels.INFO)
              end
            end)
          end
        end)

        return true
      end,
    })
    :find()
end

return M
