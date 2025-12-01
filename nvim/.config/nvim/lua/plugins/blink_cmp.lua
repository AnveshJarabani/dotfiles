return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },
    lazy = false, -- load immediately at startup
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" }, -- Enter for blink.cmp completion
        ["<TAB>"] = { "fallback" }, -- Tab falls through
      },
      appearance = {
        kind_icons = {
          Copilot = " ",
          Text = "󰉿 ",
          Method = "󰊕 ",
          Function = "󰊕 ",
          Constructor = "󰒓 ",

          Field = "󰜢 ",
          Variable = "󰆦 ",
          Property = "󰖷 ",

          Class = "󱡠 ",
          Interface = "󱡠 ",
          Struct = "󱡠 ",
          Module = "󰅩 ",

          Unit = "󰪚 ",
          Value = "󰦨 ",
          Enum = "󰦨 ",
          EnumMember = "󰦨 ",

          Keyword = "󰻾 ",
          Constant = "󰏿 ",

          Snippet = "󱄽 ",
          Color = "󰏘 ",
          File = "󰈔 ",
          Reference = "󰬲 ",
          Folder = "󰉋 ",
          Event = "󱐋 ",
          Operator = "󰪚 ",
          TypeParameter = "󰬛 ",
        },
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },

        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
          dataform = {
            name = "Dataform",
            module = "dataform.completion.blink",
          },
        },
        per_filetype = {
          sqlx = { "dataform", "lsp", "path", "snippets", "buffer" },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = {
        enabled = true,
        keymap = {
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_and_accept", "fallback" },
        },
        completion = {
          ghost_text = { enabled = true },
          menu = { auto_show = true },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
