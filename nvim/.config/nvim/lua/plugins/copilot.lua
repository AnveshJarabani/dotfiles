return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Accept Copilot suggestion with Right Arrow
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<Right>", function()
        if vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
          return vim.fn["copilot#Accept"]("")
        else
          -- Return the actual Right arrow key code
          return vim.api.nvim_replace_termcodes("<Right>", true, false, true)
        end
      end, { expr = true, replace_keycodes = false, desc = "Accept Copilot suggestion" })
    end,
  },
}
