-- AI-powered PR description generator
local M = {}

function M.generate_description()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Get list of PRs
  local handle = io.popen("gh pr list --json number,title,headRefName --jq '.[] | \"#\\(.number) - \\(.title) (\\(.headRefName))\"'")
  local result = handle:read("*a")
  handle:close()

  if result == "" then
    vim.notify("❌ No PRs found in this repository", vim.log.levels.ERROR)
    return
  end

  local prs = {}
  for line in result:gmatch("[^\r\n]+") do
    table.insert(prs, line)
  end

  pickers
    .new({}, {
      prompt_title = "Select PR to Generate Description",
      finder = finders.new_table({
        results = prs,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if not selection then
            return
          end

          -- Extract PR number from selection
          local pr_number = selection[1]:match("#(%d+)")
          if not pr_number then
            vim.notify("❌ Could not extract PR number", vim.log.levels.ERROR)
            return
          end

          M.generate_for_pr(pr_number)
        end)
        return true
      end,
    })
    :find()
end

function M.generate_for_pr(pr_number)
    -- Get PR URL and repo info
    local pr_info = vim.fn.system(string.format("gh pr view %s --json url,repository --jq '{url: .url, owner: .repository.owner.login, repo: .repository.name}'", pr_number))
    if vim.v.shell_error ~= 0 then
      vim.notify("❌ Failed to get PR info", vim.log.levels.ERROR)
      return
    end
    
    local info = vim.fn.json_decode(pr_info)
    local pr_url = info.url
    local owner = info.owner
    local repo = info.repo

    -- Get PR diff
    local diff = vim.fn.system("gh pr diff " .. pr_number)
    if vim.v.shell_error ~= 0 then
      vim.notify("❌ Failed to get PR diff", vim.log.levels.ERROR)
      return
    end

    -- Create temp file with diff
    local tmp_file = vim.fn.tempname()
    vim.fn.writefile(vim.split(diff, "\n"), tmp_file)

    -- Ask Copilot to generate description with comprehensive prompt
    vim.notify("🤖 Generating comprehensive PR description with Copilot...", vim.log.levels.INFO)
    local prompt = string.format([[Add a comprehensive PR description for %s based on the diff. Use emojis/icons to make it visually appealing and include:
- Overview/summary of changes
- What was removed, added, and refactored
- Impact summary with metrics (files changed, lines added/removed)
- Technical details
- Benefits
- Testing checklist if applicable

Use the /tmp/pr_description.md file method to pass the description to gh pr edit via GitHub API.]], pr_url)
    
    -- Use gh copilot suggest to generate description
    local cmd = string.format(
      "gh copilot suggest 'Read the diff from %s and %s' 2>&1 | tail -n +3",
      tmp_file,
      prompt
    )
    local description = vim.fn.system(cmd)

    -- Clean up
    vim.fn.delete(tmp_file)

    -- Show the generated description in a buffer for editing
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(description, "\n"))
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

    -- Open in split
    vim.cmd("split")
    vim.api.nvim_win_set_buf(0, buf)

    -- Add keymap to update PR description using gh api
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
      callback = function()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local final_desc = table.concat(lines, "\n")
        
        -- Write to /tmp/pr_description.md as specified in the prompt
        vim.fn.writefile(vim.split(final_desc, "\n"), "/tmp/pr_description.md")

        -- Use gh api with --field body=@/tmp/pr_description.md to handle special characters properly
        local result = vim.fn.system(string.format(
          "gh api repos/%s/%s/pulls/%s --method PATCH --field body=@/tmp/pr_description.md",
          owner, repo, pr_number
        ))

        if vim.v.shell_error == 0 then
          vim.notify("✅ PR description updated via GitHub API!", vim.log.levels.INFO)
          vim.cmd("close")
        else
          vim.notify("❌ Failed to update PR: " .. result, vim.log.levels.ERROR)
        end
      end,
      noremap = true,
      silent = true,
      desc = "Update PR description via GitHub API"
    })

    vim.notify("📝 Edit description and press <CR> to update PR #" .. pr_number, vim.log.levels.INFO)
end

return M
