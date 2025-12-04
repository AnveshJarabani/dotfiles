-- lua/config/keymaps.lua or within a LazyVim plugin spec

-- Combine Normal ('n') and Visual ('x') modes where appropriate
-- Note: 'v' mode usually refers to character-wise visual mode in old Vim documentation,
-- but for keymaps, 'x' generally covers all visual modes (character, line, block).
-- If you want to be extremely precise about character-wise visual, use 'v'.
-- However, 'x' is typically sufficient for these kinds of remaps.
local map = vim.keymap.set

-- Remap window navigation to Ctrl-ArrowKeys
map("n", "<M-Left>", "<C-w>h", { desc = "🔄 Go to Left Window", remap = true })
map("n", "<leader>cc", function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("code " .. vim.fn.shellescape(cwd))
  vim.notify("Opened project in VS Code: " .. cwd, vim.log.levels.INFO)
end, { desc = "💻 Open current project in VS Code" })
map("n", "<M-Down>", "<C-w>j", { desc = "🔄 Go to Lower Window", remap = true })
map("n", "<M-Up>", "<C-w>k", { desc = "🔄 Go to Upper Window", remap = true })
map("n", "<M-Right>", "<C-w>l", { desc = "🔄 Go to Right Window", remap = true })

--Remap ctrl backspce in insert mode to delete by word
map("i", "<C-H>", "<C-W>", { noremap = true })
-- Normal mode: Move current line
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "⬇️ Move Down" })
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "⬆️ Move Up" })
map("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- save file with Alt-S
map({ "n", "i", "v" }, "<A-s>", "<cmd>w<cr>", { desc = "💾 Save File (Alt+S)", noremap = true, silent = true })

map("n", "<C-Home>", "gg", { noremap = true, silent = true })
map("n", "<C-End>", "G", { noremap = true, silent = true })
-- Delete operations for Normal and Visual modes
map({ "n", "x" }, "d", [["_d]], { desc = "🗑️ Delete to blackhole register" })
-- 'dd' is line-wise, so it only makes sense in Normal mode
map("n", "dd", [["_dd]], { desc = "🗑️ Delete line to blackhole register" })
map({ "n", "x" }, "x", [["_x]], { desc = "🗑️ Delete to blackhole register" }) -- 'x' is char delete

-- Cut operations (delete + yank to clipboard) - Using 'm' for move/cut
map({ "n", "x" }, "m", [["+d]], { desc = "✂️ Cut to clipboard" })
map("n", "mm", [["+dd]], { desc = "✂️ Cut line to clipboard" })
map("n", "M", [["+D]], { desc = "✂️ Cut to end of line to clipboard" })
map("n", "miw", [["+diw]], { desc = "✂️ Cut inner word to clipboard" })
map("n", "mw", [["+dw]], { desc = "✂️ Cut word to clipboard" })

-- Change operations for Normal and Visual modes
map({ "n", "x" }, "c", [["_c]], { desc = "✏️ Change to blackhole register" })
map({ "n", "x" }, "C", [["_C]], { desc = "✏️ Change to blackhole register" })
-- 'cc' is line-wise, so it only makes sense in Normal mode
map("n", "cc", [["_cc]], { desc = "✏️ Change line to blackhole register" })
-- Specific Normal mode operations that don't have direct visual mode equivalents
-- or are typically used differently
map("n", "ciw", [["_ciw]], { desc = "✏️ Change inner word to blackhole register" })
map("n", "cw", [["_cw]], { desc = "✏️ Change word to blackhole register" })

-- Change with clipboard (cut and enter insert mode) - Using <leader>v
map({ "n", "x" }, "<leader>vc", [["+c]], { desc = "✂️ Cut and change with clipboard" })
map("n", "<leader>vcc", [["+cc]], { desc = "✂️ Cut line and change with clipboard" })
map("n", "<leader>vC", [["+C]], { desc = "✂️ Cut to end and change with clipboard" })
map("n", "<leader>viw", [["+ciw]], { desc = "✂️ Cut inner word and change with clipboard" })
map("n", "<leader>vw", [["+cw]], { desc = "✂️ Cut word and change with clipboard" })

-- For 'S' (substitute line), it's a normal mode command.
-- map("n", "S", [["_S]], { desc = "Substitute line to blackhole register" })

-- use escape to close any popup windows
map("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = "❌ Close all floating windows with Esc" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "noice", "copilot", "codecompanion", "qf", "help", "markdown" }, -- add filetypes that open in splits
  callback = function()
    -- Map <Esc> to close the window/buffer
    map("n", "<Esc>", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})
-- Map the <leader><leader> to `find_files`
map("n", "<leader><leader>", function()
  require("telescope.builtin").find_files()
end, { desc = "🔍 Telescope: Find Files" })

-- Map <leader>/ to find files in the home directory
map("n", "<leader>/", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand("~") })
end, { desc = "🏠 Telescope: Find Files root directory" })

-- Map <leader>; to live grep
map("n", "<leader>;", function()
  require("telescope.builtin").live_grep()
end, { desc = "🔎 Telescope: Live Grep" })
map("n", "<leader>'", function()
  require("telescope.builtin").live_grep({ cwd = vim.fn.expand("~") })
end, { desc = "🔎 Telescope: Live Grep (root directory)" })
-- Scroll up/down half a screen with Ctrl+Up / Ctrl+Down
map("n", "<C-Up>", "<C-u>", { noremap = true, silent = true })
map("n", "<C-Down>", "<C-d>", { noremap = true, silent = true })

-- (Optional) Also add to insert/visual mode if needed
map("i", "<C-Up>", "<C-o><C-u>", { noremap = true, silent = true })
map("i", "<C-Down>", "<C-o><C-d>", { noremap = true, silent = true })

map("v", "<C-Up>", "<C-u>", { noremap = true, silent = true })
map("v", "<C-Down>", "<C-d>", { noremap = true, silent = true })

-- Map Space + n to NoiceTelescope
map("n", "<Space>n", ":NoiceTelescope<CR>", { noremap = true, silent = true })

-- Map Ctrl+b to Telescope Buffers
map("n", "<C-b>", function()
  require("telescope.builtin").buffers()
end, { desc = "📋 Telescope: Switch Buffers" })

map("n", "<space>tb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "📋 Telescope: Buffers" })
map("n", "<space>bt", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "📋 Telescope: Buffers" })
map(
  "n",
  "<space>tf",
  "<cmd>Telescope find_files<CR>",
  { noremap = true, silent = true, desc = "🔍 Telescope: Find Files" }
)
map(
  "n",
  "<space>tg",
  "<cmd>Telescope live_grep<CR>",
  { noremap = true, silent = true, desc = "🔎 Telescope: Live Grep" }
)
map(
  "n",
  "<space>th",
  "<cmd>Telescope help_tags<CR>",
  { noremap = true, silent = true, desc = "❓ Telescope: Help Tags" }
)
map("n", "<space>tm", "<cmd>Telescope marks<CR>", { noremap = true, silent = true, desc = "🔖 Telescope: Marks" })
map(
  "n",
  "<space>tr",
  "<cmd>Telescope oldfiles<CR>",
  { noremap = true, silent = true, desc = "📄 Telescope: Recent Files" }
)
map(
  "n",
  "<space>tt",
  "<cmd>Telescope treesitter<CR>",
  { noremap = true, silent = true, desc = "🌳 Telescope: Treesitter" }
)
map(
  "n",
  "<space>tc",
  "<cmd>Telescope frecency<CR>",
  { noremap = true, silent = true, desc = "🎯 Telescope: Frecency" }
)
map("n", "<leader>rm", [[:%s/\r//g<CR>]], { noremap = true, silent = true })
map("v", "<leader>rm", [[:s/\r//g<CR>]], { noremap = true, silent = true })
map("n", "<space>zz", ":qa!<CR>", { desc = "🚪 Quit All" })

-- GitHub search functions
map("n", "<leader>gs", function()
  require("config.gh-search").search_code()
end, { noremap = true, silent = true, desc = "🔍 GitHub Code Search" })

map("n", "<leader>zl", function()
  require("snacks").lazygit()
end, { noremap = true, silent = true, desc = "🚀 LazyGit" })
map("n", "<leader>zf", function()
  require("snacks").lazygit({ args = { "--screen-mode", "full" } })
end, { noremap = true, silent = true, desc = "🚀 LazyGit Fullscreen" })
map("n", "ZQ", ":qa!<CR>")
map("n", "ZZ", ":wqa!<CR>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- map("n", "<C-_>", function()
--   local buf_path = vim.api.nvim_buf_get_name(0)
--   local dir = buf_path ~= "" and vim.fn.fnamemodify(buf_path, ":p:h") or vim.loop.cwd()
--   require("toggleterm.terminal").Terminal:new({ direction = "float", dir = dir }):toggle()
-- end, { desc = "Toggle floating terminal in buffer dir" })

local main_term
map("n", "<leader>tl", function()
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  local dir
  if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
    dir = git_root
  else
    dir = vim.fn.getcwd()
  end
  if not main_term then
    main_term = require("toggleterm.terminal").Terminal:new({ direction = "float", dir = dir, name = "main_term" })
  end
  main_term:toggle()
end, { desc = "💻 Toggle main floating terminal in project root dir" })

local gemini_term
map("n", "<leader>tg", function()
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  local dir
  if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
    dir = git_root
  else
    dir = vim.fn.getcwd()
  end
  if not gemini_term then
    gemini_term = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "gemini",
      name = "gemini_term",
    })
  end
  gemini_term:toggle()
end, { desc = "♊ Toggle Gemini floating terminal in project root dir" })

local copilot_term
map("n", "<leader>tc", function()
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  local dir
  if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
    dir = git_root
  else
    dir = vim.fn.getcwd()
  end
  if not copilot_term then
    copilot_term = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "copilot",
      name = "copilot_term",
    })
  end
  copilot_term:toggle()
end, { desc = "🤖 Toggle Copilot floating terminal in project root dir" })

local claude_term
map("n", "<leader>td", function()
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  local dir
  if git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1 then
    dir = git_root
  else
    dir = vim.fn.getcwd()
  end
  if not claude_term then
    claude_term = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "claude",
      name = "claude_term",
    })
  end
  claude_term:toggle()
end, { desc = "🤖 Toggle Claude floating terminal in project root dir" })

map("i", "<C-y>", function()
  require("copilot.suggestion").accept()
end, { desc = "🤖 Copilot Accept" })

-- Session management keybindings
map("n", "<leader>ss", ":AutoSession search<CR>", { desc = "🔍 SessionSearch" })
map("n", "<leader>sw", "<cmd>SessionSave<CR>", { desc = "💾 Save Current Session" })
map("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "📂 Restore Session" })
map("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "🗑️ Delete Session" })

map("n", "<leader>yd", function()
  local dir = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", dir)
  vim.notify("Copied directory to clipboard:\n" .. dir, vim.log.levels.INFO)
end, { desc = "📁 Copy buffer directory to clipboard" })

map("n", "<leader>yb", function()
  local path = vim.fn.expand("%:p:r")
  vim.fn.setreg("+", path)
  vim.notify("Copied file path to clipboard:\n" .. path, vim.log.levels.INFO)
end, { desc = "📄 Copy buffer file path to clipboard" })

map("n", "<leader>yw", function()
  local filepath = vim.fn.expand("%:p")
  local win_path = vim.fn.system("wslpath -w " .. vim.fn.shellescape(filepath)):gsub("\n", "")
  vim.fn.setreg("+", win_path)
  vim.notify("Copied Windows path to clipboard:\n" .. win_path, vim.log.levels.INFO)
end, { desc = "🪟 Copy buffer path as Windows path (WSL)" })

map("n", "<leader>ye", function()
  local filepath = vim.fn.expand("%:p")
  local win_path = vim.fn.system("wslpath -w " .. vim.fn.shellescape(filepath)):gsub("\n", "")
  vim.fn.system("/mnt/c/Program\\ Files/OneCommander/OneCommander.exe " .. vim.fn.shellescape(win_path))
  vim.notify("Opened in One Commander:\n" .. win_path, vim.log.levels.INFO)
end, { desc = "🪟 Open buffer directory in One Commander" })

map("n", "<leader>yf", function()
  local filename = vim.fn.expand("%:t:r")
  vim.fn.setreg("+", filename)
  vim.notify("Copied file name to clipboard:\n" .. filename, vim.log.levels.INFO)
end, { desc = "📝 Copy buffer file name to clipboard" })

map("n", "<leader>yp", function()
  local cwd = vim.fn.getcwd()
  local filepath = vim.fn.expand("%:p")
  local relative_path = vim.fn.fnamemodify(filepath, ":.")
  relative_path = "./" .. relative_path
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied project-relative path to clipboard:\n" .. relative_path, vim.log.levels.INFO)
end, { desc = "📍 Copy project-relative path to clipboard" })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Diff operations
map("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "🔍 Diff View Open" })
map("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "❌ Diff View Close" })

map("n", "<leader>qc", "<cmd>call setqflist([])<CR>", { desc = "🧹 Clear quickfix list" })

-- Other useful quickfix mappings
map("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "❌ Close quickfix list" })
map("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "⏭️ Next quickfix item" })
map("n", "<leader>qp", "<cmd>cprev<CR>", { desc = "⏮️ Previous quickfix item" })

-- Function to remove trailing whitespace from current buffer
local function remove_trailing_whitespace()
  vim.cmd([[%s/\s\+$//e]])
  print("Removed trailing whitespace from current buffer")
end

-- Create user command
vim.api.nvim_create_user_command("RemoveTrailingWhitespace", remove_trailing_whitespace, {})

-- Create hotkey
map("n", "<leader>tw", remove_trailing_whitespace, { desc = "🧹 Remove trailing whitespace from current buffer" })
map("n", "<leader>gm", function()
  -- Get git root directory
  local git_root_cmd = "git rev-parse --show-toplevel"
  local git_root = vim.fn.trim(vim.fn.system(git_root_cmd .. " 2>/dev/null"))
  local dir = (git_root and git_root ~= "" and vim.fn.isdirectory(git_root) == 1) and git_root or vim.fn.getcwd()
  
  -- Create prompt for commit message
  local prompt = 'add commit message with lots of fun fancy modern icons'
  
  -- Get or create copilot terminal (shared with <leader>tc)
  if not copilot_term then
    copilot_term = require("toggleterm.terminal").Terminal:new({
      direction = "float",
      dir = dir,
      cmd = "copilot",
      name = "copilot_term",
    })
  end
  
  -- Open terminal
  copilot_term:toggle()
  
  -- Wait a bit for terminal to be ready, then send the prompt
  vim.defer_fn(function()
    copilot_term:send(prompt)
  end, 500)
  
  vim.notify("🤖 Commit message prompt injected into Copilot terminal!", vim.log.levels.INFO)
end, { desc = "🤖 Generate commit message with Copilot" })
--just a newterminal
map("n", "<leader>tn", function()
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
end, { desc = "➕ Create new named terminal" })

-- Octo (GitHub integration) mappings
map("n", "<leader>ol", "<cmd>Octo pr list<CR>", { desc = "📋 Octo: List PRs" })
map("n", "<leader>od", "<cmd>Octo pr diff<CR>", { desc = "🔍 Octo: PR diff" })
map("n", "<leader>ob", "<cmd>Octo pr browser<CR>", { desc = "🌐 Octo: Open PR in browser" })
map("n", "<leader>oc", "<cmd>Octo pr create<CR>", { desc = "✨ Octo: Create PR" })
map("n", "<leader>om", "<cmd>Octo pr merge<CR>", { desc = "🔀 Octo: Merge PR" })
map("n", "<leader>or", "<cmd>Octo pr review<CR>", { desc = "👀 Octo: Review PR" })
map("n", "<leader>os", "<cmd>Octo pr status<CR>", { desc = "📊 Octo: PR status" })
map("n", "<leader>oo", "<cmd>Octo pr checkout<CR>", { desc = "🔄 Octo: Checkout PR" })
map("n", "<leader>ou", function()
  -- First copy the URL
  vim.cmd("Octo pr url")
  -- Then open it in browser (similar to gx behavior)
  local url = vim.fn.getreg("+")
  if url and url ~= "" then
    vim.fn.system("xdg-open " .. vim.fn.shellescape(url))
    vim.notify("Opened PR in browser: " .. url, vim.log.levels.INFO)
  end
end, { desc = "🔗 Octo: Copy & open PR URL in browser" })
map("n", "<leader>oi", "<cmd>Octo issue list<CR>", { desc = "📋 Octo: List issues" })
map("n", "<leader>ox", "<cmd>Octo issue close<CR>", { desc = "❌ Octo: Close issue" })
map("n", "<leader>on", "<cmd>Octo issue create<CR>", { desc = "✨ Octo: Create issue" })
map("n", "<leader>oe", "<cmd>Octo issue edit<CR>", { desc = "✏️ Octo: Edit issue" })
map("n", "<leader>op", function()
  require("config.pr-description").generate_description()
end, { desc = "🤖 AI: Generate PR Description" })

-- Git commands
map("n", "<leader>gS", ":!git status<CR>", { desc = "📊 Git status" })
map("n", "<leader>gP", ":!git push<CR>", { desc = "⬆️ Git push" })
map("n", "<leader>gp", ":!git pull<CR>", { desc = "⬇️ Git pull" })
map("n", "<leader>gb", function()
  require("config.git-branches").pick_branch()
end, { desc = "🌿 Git: Checkout/Create Branch" })

map("n", "<leader>gM", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local pr_number = bufname:match("pull/(%d+)") or bufname:match("pr/(%d+)")

  if not pr_number then
    vim.notify("Not in a PR buffer. Current buffer: " .. bufname, vim.log.levels.ERROR)
    return
  end

  -- Extract repo from buffer name (e.g., mediwareinc/wsh-bi-dataform)
  local repo = bufname:match("octo://([^/]+/[^/]+)/")
  if not repo then
    vim.notify("Could not extract repository from buffer name", vim.log.levels.ERROR)
    return
  end

  vim.notify("Generating description for PR #" .. pr_number, vim.log.levels.INFO)

  -- Get the diff
  local diff_cmd = string.format("gh pr diff %s --repo %s", pr_number, repo)
  local handle = io.popen(diff_cmd)
  local diff = handle:read("*a")
  handle:close()

  if diff == "" then
    vim.notify("No diff found for PR #" .. pr_number, vim.log.levels.ERROR)
    return
  end

  -- Generate description with copilot - pass diff via stdin
  local copilot_cmd = string.format(
    "gh pr diff %s --repo %s | copilot -p 'Generate a fancy PR description with emojis based on this diff. Include what changed, why, and any notes. Make it professional but fun.' --allow-all-tools",
    pr_number,
    repo
  )

  local handle2 = io.popen(copilot_cmd)
  local description = handle2:read("*a")
  handle2:close()

  if description ~= "" then
    -- Update PR with generated description
    local update_cmd =
      string.format("gh pr edit %s --repo %s --body %s", pr_number, repo, vim.fn.shellescape(description))
    vim.fn.system(update_cmd)
    vim.fn.setreg("+", description)
    vim.notify("PR #" .. pr_number .. " description updated!", vim.log.levels.INFO)
  else
    vim.notify("Failed to generate description", vim.log.levels.ERROR)
  end
end, { desc = "🤖 Generate PR description with Copilot CLI" })

map("n", "<leader>ts", function()
  local toggleterm = require("toggleterm.terminal")
  local terms = toggleterm.get_all()
  if #terms == 0 then
    vim.notify("No terminals open", vim.log.levels.WARN)
    return
  end
  vim.ui.select(
    vim.tbl_map(function(t)
      return t.display_name or t.name or "Terminal " .. t.id
    end, terms),
    { prompt = "Select terminal:" },
    function(choice, idx)
      if choice then
        terms[idx]:toggle()
      end
    end
  )
end, { desc = "🔭 Select and toggle terminal" })
