return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = function()
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      use_icons = true,
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      commit_log_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- Set local keymaps for diff buffers
          local opts = { buffer = bufnr, silent = true }

          -- Undo/drop changes
          vim.keymap.set(
            "n",
            "<leader>ghu",
            "<cmd>Gitsigns undo_stage_hunk<cr>",
            vim.tbl_extend("force", opts, { desc = "Undo stage hunk" })
          )
          vim.keymap.set(
            "n",
            "<leader>ghr",
            "<cmd>Gitsigns reset_hunk<cr>",
            vim.tbl_extend("force", opts, { desc = "Reset/drop hunk" })
          )
          vim.keymap.set(
            "v",
            "<leader>ghr",
            "<cmd>Gitsigns reset_hunk<cr>",
            vim.tbl_extend("force", opts, { desc = "Reset/drop hunk" })
          )

          -- Stage changes
          vim.keymap.set(
            "n",
            "<leader>ghs",
            "<cmd>Gitsigns stage_hunk<cr>",
            vim.tbl_extend("force", opts, { desc = "Stage hunk" })
          )
          vim.keymap.set(
            "v",
            "<leader>ghs",
            "<cmd>Gitsigns stage_hunk<cr>",
            vim.tbl_extend("force", opts, { desc = "Stage hunk" })
          )
        end,
      },
      view = {
        default = {
          layout = "diff2_vertical",
          disable_diagnostics = true,
        },
        merge_tool = {
          layout = "diff3_vertical",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_vertical",
          disable_diagnostics = true,
        },
      },
    })
  end,
}
