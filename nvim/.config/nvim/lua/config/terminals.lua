-- Terminal management module
local M = {}

-- Shared terminal instances
local terminals = {
  main = nil,
  gemini = nil,
  copilot = nil,
  claude = nil,
}

local function get_project_root()
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
    return git_root
  else
    return vim.fn.getcwd()
  end
end

function M.toggle_main()
  local dir = get_project_root()
  if not terminals.main then
    terminals.main = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      name = "main_term"
    })
  end
  terminals.main:toggle()
end

function M.toggle_gemini()
  local dir = get_project_root()
  if not terminals.gemini then
    terminals.gemini = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "gemini",
      name = "gemini_term",
    })
  end
  terminals.gemini:toggle()
end

function M.toggle_copilot()
  local dir = get_project_root()
  if not terminals.copilot then
    terminals.copilot = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "copilot",
      name = "copilot_term",
    })
  end
  terminals.copilot:toggle()
end

function M.get_copilot_term()
  if not terminals.copilot then
    local dir = get_project_root()
    terminals.copilot = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "copilot",
      name = "copilot_term",
    })
  end
  return terminals.copilot
end

function M.toggle_claude()
  local dir = get_project_root()
  if not terminals.claude then
    terminals.claude = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "claude",
      name = "claude_term",
    })
  end
  terminals.claude:toggle()
end

function M.create_named_terminal()
  vim.ui.input({ prompt = "Terminal name: " }, function(name)
    if not name or name == "" then
      return
    end
    local Terminal = require("toggleterm.terminal").Terminal
    local new_term = Terminal:new({
      direction = "float",
      name = name,
    })
    new_term:toggle()
  end)
end

function M.show_terminal_list()
  local toggleterm = require("toggleterm.terminal")
  local terms = toggleterm.get_all()
  if #terms == 0 then
    vim.notify("No terminals found", vim.log.levels.INFO)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local terminal_list = {}
  for _, term in ipairs(terms) do
    table.insert(terminal_list, {
      name = term.name or "Unnamed",
      id = term.id,
      dir = term.dir or "N/A",
      term = term,
    })
  end

  pickers
    .new({}, {
      prompt_title = "Terminals",
      finder = finders.new_table({
        results = terminal_list,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format("[%d] %s (%s)", entry.id, entry.name, entry.dir),
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            selection.value.term:toggle()
          end
        end)
        return true
      end,
    })
    :find()
end

return M
