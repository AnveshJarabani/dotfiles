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
    local tmp_file = "/tmp/pr_diff_" .. pr_number .. ".diff"
    vim.fn.writefile(vim.split(diff, "\n"), tmp_file)

    -- Build the comprehensive prompt
    local prompt = string.format([[Add a comprehensive PR description for %s based on the diff in %s. Use emojis/icons to make it visually appealing and include:
- Overview/summary of changes
- What was removed, added, and refactored
- Impact summary with metrics (files changed, lines added/removed)
- Technical details
- Benefits
- Testing checklist if applicable

Use the /tmp/pr_description.md file method to pass the description to gh pr edit via GitHub API:

cat > /tmp/pr_description.md << 'EOF'
<your markdown content here>
EOF
gh api repos/%s/%s/pulls/%s --method PATCH --field body=@/tmp/pr_description.md]], pr_url, tmp_file, owner, repo, pr_number)

    -- Get copilot terminal from terminals module
    local terminals = require("config.terminals")
    local copilot_term = terminals.get_copilot_term()
    
    -- Open terminal
    copilot_term:toggle()
    
    -- Wait a bit for terminal to be ready, then send the prompt
    vim.defer_fn(function()
      copilot_term:send(prompt)
    end, 500)
    
    vim.notify("🤖 Prompt injected into Copilot terminal. Review and execute!", vim.log.levels.INFO)
end

return M
