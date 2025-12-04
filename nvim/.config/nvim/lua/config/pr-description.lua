-- AI-powered PR description generator
local M = {}

function M.generate_description()
  -- Get PR URL from current Octo buffer (same as <leader>ou)
  vim.cmd("Octo pr url")
  local pr_url = vim.fn.getreg("+")
  
  if not pr_url or pr_url == "" then
    vim.notify("❌ Not in an Octo PR buffer. Open a PR first with <leader>ol", vim.log.levels.ERROR)
    return
  end

  vim.notify("🤖 Generating comprehensive PR description...", vim.log.levels.INFO)
  
  -- Extract owner, repo, and PR number from URL
  -- Format: https://github.com/owner/repo/pull/123
  local owner, repo, pr_number = pr_url:match("github%.com/([^/]+)/([^/]+)/pull/(%d+)")
  
  if not owner or not repo or not pr_number then
    vim.notify("❌ Could not parse PR URL: " .. pr_url, vim.log.levels.ERROR)
    return
  end

  M.generate_for_pr(pr_number, owner, repo, pr_url)
end

function M.generate_for_pr(pr_number, owner, repo, pr_url)

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
