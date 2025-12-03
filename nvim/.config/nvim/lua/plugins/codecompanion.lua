return {
  {
    "olimorris/codecompanion.nvim",
    version = "v17.33.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      { "stevearc/dressing.nvim", opts = {} },
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4.5",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = " 🤖 ",
            user = " 👱 ",
          },
        },
        inline = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          window = {
            layout = "float",
            width = 0.9,
            height = 0.95,
            relative = "editor",
            border = "rounded",
            title = "Copilot",
          },
          show_settings = false,
          show_token_count = false,
        },
      },
      opts = {
        log_level = "ERROR",
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        desc = "Clear (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        function()
          vim.cmd("CodeCompanionChat stop")
        end,
        desc = "Stop (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          vim.cmd("CodeCompanionChat Add")
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, { "Optimize this code" })
          end, 100)
        end,
        desc = "Optimize Code (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Prompt Actions (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat Add")
          vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, {
              "Write commit message for the staged changes with commitizen convention. Keep the title under 50 characters and no wrap message, include a nice emoji at the start. Format as a gitcommit code block.",
            })
          end, 100)
        end,
        desc = "Generate Commit Message",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codecompanion",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
    end,
  },
}
