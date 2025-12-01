-- https://github.com/okuuva/auto-save.nvim
--
-- This is a fork of original plugin `https://github.com/pocco81/auto-save.nvim`
-- but the original one was updated 2 years ago, and I was experiencing issues
-- with autoformat and undo/redo
--
-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/auto-save.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/auto-save.lua

-- My related YouTube video
-- Save neovim files automatically with auto-save.nvim
-- https://youtu.be/W5fjlU4tSpw

-- I had undo/redo issues when using the no longer maintained plugin from pocco81
-- So make sure you're using the right plugin, which is okuuva/auto-save.nvim
-- https://github.com/pocco81/auto-save.nvim/issues/70

-- Autocommand for printing the autosaved message
local group = vim.api.nvim_create_augroup("autosave", {})
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveWritePost",
  group = group,
  callback = function(opts)
    if opts.data.saved_buffer ~= nil then
      -- print("AutoSaved at " .. vim.fn.strftime("%H:%M:%S"))
      print("AutoSaved")
    end
  end,
})

-- I do not want to save when I'm in visual mode because I'm usually moving
-- stuff from one place to another, or deleting it
-- I got this suggestion from the plugin maintainers
-- https://github.com/okuuva/auto-save.nvim/issues/67#issuecomment-2597631756
local visual_event_group = vim.api.nvim_create_augroup("visual_event", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = visual_event_group,
  pattern = { "*:[vV\x16]*" },
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VisualEnter" })
    -- print("VisualEnter")
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group = visual_event_group,
  pattern = { "[vV\x16]*:*" },
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VisualLeave" })
    -- print("VisualLeave")
  end,
})

-- Override the `flash.jump` function to detect start and end
local flash = require("flash")
local original_jump = flash.jump

flash.jump = function(opts)
  vim.api.nvim_exec_autocmds("User", { pattern = "FlashJumpStart" })
  -- print("flash.nvim enter")

  original_jump(opts)

  vim.api.nvim_exec_autocmds("User", { pattern = "FlashJumpEnd" })
  -- print("flash.nvim leave")
end

-- Disable auto-save when entering a snacks_input buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_input",
  group = group,
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "SnacksInputEnter" })
    -- print("snacks input enter")
  end,
})

-- Re-enable auto-save when leaving that buffer
vim.api.nvim_create_autocmd("BufLeave", {
  group = group,
  pattern = "*", -- check all buffers
  callback = function(opts)
    local ft = vim.bo[opts.buf].filetype
    if ft == "snacks_input" then
      vim.api.nvim_exec_autocmds("User", { pattern = "SnacksInputLeave" })
      -- print("snacks input leave")
    end
  end,
})

-- Disable auto-save when entering a snacks_input buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_picker_input",
  group = group,
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "SnacksPickerInputEnter" })
    -- print("snacks picker input enter")
  end,
})

-- Re-enable auto-save when leaving that buffer
vim.api.nvim_create_autocmd("BufLeave", {
  group = group,
  pattern = "*", -- check all buffers
  callback = function(opts)
    local ft = vim.bo[opts.buf].filetype
    if ft == "snacks_picker_input" then
      vim.api.nvim_exec_autocmds("User", { pattern = "SnacksPickerInputLeave" })
      -- print("snacks picker input leave")
    end
  end,
})

return {
  {
    "okuuva/auto-save.nvim",
    enabled = false, -- I disable it by default, so I can enable it manually
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
        defer_save = {
          "InsertLeave",
          "TextChanged",
          { "User", pattern = "VisualLeave" },
          { "User", pattern = "FlashJumpEnd" },
          { "User", pattern = "SnacksInputLeave" },
          { "User", pattern = "SnacksPickerInputLeave" },
        },
        cancel_deferred_save = {
          "InsertEnter",
          { "User", pattern = "VisualEnter" },
          { "User", pattern = "FlashJumpStart" },
          { "User", pattern = "SnacksInputEnter" },
          { "User", pattern = "SnacksPickerInputEnter" },
        },
      },
      condition = function(buf)
        local mode = vim.fn.mode()
        if mode == "i" then
          return false
        end

        local filetype = vim.bo[buf].filetype
        if filetype == "harpoon" or filetype == "mysql" then
          return false
        end

        if require("luasnip").in_snippet() then
          return false
        end

        return true
      end,
      write_all_buffers = false,
      noautocmd = false,
      lockmarks = false,
      debounce_delay = 2000,
      debug = false,
    },
  },
}
