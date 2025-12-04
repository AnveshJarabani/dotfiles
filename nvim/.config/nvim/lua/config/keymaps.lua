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
  require("config.clipboard-utils").open_in_vscode()
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
  require("config.window-utils").close_floating_windows()
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
  require("config.terminals").toggle_main()
end, { desc = "💻 Toggle main floating terminal in project root dir" })

local gemini_term
map("n", "<leader>tg", function()
  require("config.terminals").toggle_gemini()
end, { desc = "♊ Toggle Gemini floating terminal in project root dir" })

local copilot_term
map("n", "<leader>tc", function()
  require("config.terminals").toggle_copilot()
end, { desc = "🤖 Toggle Copilot floating terminal in project root dir" })

local claude_term
map("n", "<leader>td", function()
  require("config.terminals").toggle_claude()
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
  require("config.clipboard-utils").copy_buffer_directory()
end, { desc = "📁 Copy buffer directory to clipboard" })

map("n", "<leader>yb", function()
  require("config.clipboard-utils").copy_buffer_filepath()
end, { desc = "📄 Copy buffer file path to clipboard" })

map("n", "<leader>yw", function()
  require("config.clipboard-utils").copy_windows_path()
end, { desc = "🪟 Copy buffer path as Windows path (WSL)" })

map("n", "<leader>ye", function()
  require("config.clipboard-utils").open_in_one_commander()
end, { desc = "🪟 Open buffer directory in One Commander" })

map("n", "<leader>yf", function()
  require("config.clipboard-utils").copy_filename()
end, { desc = "📝 Copy buffer file name to clipboard" })

map("n", "<leader>yp", function()
  require("config.clipboard-utils").copy_relative_path()
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
vim.api.nvim_create_user_command("RemoveTrailingWhitespace", function()
  require("config.window-utils").remove_trailing_whitespace()
end, {})

-- Create hotkey
map("n", "<leader>tw", function()
  require("config.window-utils").remove_trailing_whitespace()
end, { desc = "🧹 Remove trailing whitespace from current buffer" })
map("n", "<leader>gm", function()
  require("config.commit-message").generate_commit_message()
end, { desc = "🤖 Generate commit message with Copilot" })
--just a newterminal
map("n", "<leader>tn", function()
  require("config.terminals").create_named_terminal()
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

map("n", "<leader>ts", function()
  require("config.terminals").show_terminal_list()
end, { desc = "🔭 Select and toggle terminal" })
