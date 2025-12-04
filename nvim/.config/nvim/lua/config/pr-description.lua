-- AI-powered PR description generator
local M = {}

function M.generate_description()
  vim.ui.input({ prompt = "Enter PR number (or leave blank for current branch): " }, function(pr_number)
    if not pr_number or pr_number == "" then
      -- Get current branch's PR
      local branch = vim.fn.system("git branch --show-current"):gsub("%s+", "")
      local pr_info = vim.fn.system("gh pr view --json number,title -q '.number' 2>/dev/null"):gsub("%s+", "")
      if pr_info == "" then
        vim.notify("❌ No PR found for current branch", vim.log.levels.ERROR)
        return
      end
      pr_number = pr_info
    end

    -- Get PR diff
    local diff = vim.fn.system("gh pr diff " .. pr_number)
    if vim.v.shell_error ~= 0 then
      vim.notify("❌ Failed to get PR diff", vim.log.levels.ERROR)
      return
    end

    -- Create temp file with diff
    local tmp_file = vim.fn.tempname()
    vim.fn.writefile(vim.split(diff, "\n"), tmp_file)

    -- Ask Copilot to generate description
    vim.notify("🤖 Generating PR description with Copilot...", vim.log.levels.INFO)
    local prompt = "Based on this PR diff, generate a professional PR description with emojis. Include: summary, key changes, and impact. Use markdown formatting."
    
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

    -- Add keymap to update PR description
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
      callback = function()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local final_desc = table.concat(lines, "\n")
        local tmp_desc = vim.fn.tempname()
        vim.fn.writefile(vim.split(final_desc, "\n"), tmp_desc)

        local result = vim.fn.system(string.format("gh pr edit %s --body-file %s", pr_number, tmp_desc))
        vim.fn.delete(tmp_desc)

        if vim.v.shell_error == 0 then
          vim.notify("✅ PR description updated!", vim.log.levels.INFO)
          vim.cmd("close")
        else
          vim.notify("❌ Failed to update PR: " .. result, vim.log.levels.ERROR)
        end
      end,
      noremap = true,
      silent = true,
      desc = "Update PR description"
    })

    vim.notify("📝 Edit description and press <CR> to update PR #" .. pr_number, vim.log.levels.INFO)
  end)
end

return M
