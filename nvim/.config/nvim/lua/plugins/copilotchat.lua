return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = false,
        question_header = " 👱 ",
        answer_header = " 🤖 ",
        -- sticky = { "#buffer:active", "#files:all", "$claude-sonnet-4" },
        sticky = { "#buffer:active", "#files:all", "$claude-haiku-4.5" },
        context = "buffers",
        prompts = {
          CommitMessage = {
            prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and no wrap message, include a nice emoji at the start. Format as a gitcommit code block.",
            context = "git:staged",
            mapping = "<leader>ac",
            description = "Generate Commit Message",
          },
        },

        window = {
          layout = "float",
          width = 0.9,
          height = 0.95,
          relative = "win",
          row = nil,
          col = nil,
          border = "rounded",
          title = "Copilot",
        },
        mappings = {
          complete = {
            insert = "<C-t>",
          },
          show_diff = {
            normal = "gd",
            full_diff = true, -- Show full diff instead of unified diff when showing diff window
          },
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        function()
          require("CopilotChat").stop()
        end,
        desc = "Stop (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          vim.cmd("CopilotChatOptimize")
        end,
        desc = "Optimize Code (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aw",
        function()
          vim.cmd("CopilotChatSave")
        end,
        desc = "Save Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>al",
        function()
          vim.cmd("CopilotChatLoad")
        end,
        desc = "Load Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
} -- See Commands section for default commands if you want to lazy load on them
