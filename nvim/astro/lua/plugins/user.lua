local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "onsails/lspkind.nvim" },
    },
    opts = function(_, opts)
      local lspkind = require "lspkind"
      opts.formatting.fields = {
        "abbr",
        "kind",
        "menu",
      }
      opts.formatting.format = lspkind.cmp_format {
        mode = "symbol",
        maxwidth = 50,
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        },
      }

      return opts
    end,
  },
  { "mason.nvim", opts = { PATH = "append" } },
  -- { "lbrayner/vim-rzip", event = "BufEnter" },
  {
    "ggandor/leap.nvim",
    enabled = false,
    lazy = false,
    config = function() require("leap").add_default_mappings() end,
  },
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {
      default_args = { DiffviewOpen = { "--imply-local" } },
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = "diff4_mixed" } },
    },
  }, --[[ {
            "samoshkin/vim-mergetool",
            lazy = false,
            config = function()
                vim.g.mergetool_layout = "bmr"
                require("vim-mergetool").setup()
            end
        } ]]
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        cmp = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
      },
      custom_highlights = function(colors)
        return {
          CmpBorder = { fg = colors.lavender, bg = colors.levender },
        }
      end,
    },
  },
  -- { "github/copilot.vim", event = "InsertEnter", cmd = "Copilot" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEnter",
    setup = function()
      local rainbow_delimiters = require "rainbow-delimiters"
      require("rainbow-delimiters.setup").setup { [""] = rainbow_delimiters.strategy["local"] }
    end,
  },
  {
    "indent-blankline.nvim",
    opts = {
      indent = { char = "▏" },
      scope = { char = "▎", highlight = highlight },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    opts = {
      floating_window = true,
      hint_enable = false,
    },
    config = function(_, opts) require("lsp_signature").setup(opts) end,
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mods = "topline",
      max_lines = 5,
    },
    config = function(_, opts)
      local theme = require("catppuccin.palettes").get_palette "mocha"
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = theme.surface0 })
      require("treesitter-context").setup(opts)
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter", "catppuccin/nvim" },
  },
}
