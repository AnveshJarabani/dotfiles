return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = true,
  opts = {
    signcolumn = true,
    attach_to_untracked = true,
    watch_gitdir = {
      follow_files = true,
    },
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Navigation mappings with diff mode support
      local nav_mappings = {
        ["<leader>ghn"] = {
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end,
          "🔽 Next Hunk",
        },
        ["<leader>ghp"] = {
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end,
          "🔼 Prev Hunk",
        },
        ["<leader>ghl"] = {
          function()
            gs.nav_hunk("last")
          end,
          "⏭️ Last Hunk",
        },
        ["<leader>ghf"] = {
          function()
            gs.nav_hunk("first")
          end,
          "⏮️ First Hunk",
        },
      }

      -- Git operations mappings
      local git_mappings = {
        ["<leader>ghs"] = { ":Gitsigns stage_hunk<CR>", "📦 Stage Hunk", { "n", "v" } },
        ["<leader>gr"] = { ":Gitsigns reset_hunk<CR>", "🔄 Reset Hunk", { "n", "v" } },
        ["<leader>ghS"] = { gs.stage_buffer, "📦 Stage Buffer", "n" },
        ["<leader>ghu"] = { gs.undo_stage_hunk, "↩️ Undo Stage Hunk", "n" },
        ["<leader>ghR"] = { gs.reset_buffer, "🔄 Reset Buffer", "n" },
        ["<leader>ghv"] = { gs.preview_hunk_inline, "👁️ Preview Hunk Inline", "n" },
        ["<leader>ghb"] = {
          function()
            gs.blame_line({ full = true })
          end,
          "👤 Blame Line",
          "n",
        },
        ["<leader>ghB"] = {
          function()
            gs.blame()
          end,
          "👥 Blame Buffer",
          "n",
        },
        ["<leader>ghd"] = { gs.diffthis, "🔍 Diff This", "n" },
        ["<leader>ghD"] = {
          function()
            gs.diffthis("~")
          end,
          "🔍 Diff This ~",
          "n",
        },
        ["ih"] = { ":<C-U>Gitsigns select_hunk<CR>", "🎯 GitSigns Select Hunk", { "o", "x" } },
      }

      -- Apply navigation mappings
      for key, mapping in pairs(nav_mappings) do
        map("n", key, mapping[1], mapping[2])
      end

      -- Apply git operation mappings
      for key, mapping in pairs(git_mappings) do
        local modes = mapping[3] or "n"
        map(modes, key, mapping[1], mapping[2])
      end
    end,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- Set up clear red and green colors for git signs
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffff00", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ff0000", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#ff8800", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#888888", bold = true })

    -- Staged signs
    vim.api.nvim_set_hl(0, "GitSignsAddStaged", { fg = "#00aa00", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsChangeStaged", { fg = "#aaaa00", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsDeleteStaged", { fg = "#aa0000", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsTopdeleteStaged", { fg = "#aa0000", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsChangedeleteStaged", { fg = "#aa4400", bold = true })
  end,
}
