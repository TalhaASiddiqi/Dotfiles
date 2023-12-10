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
  { "mason.nvim", opts = { PATH = "append" } },
  { "lbrayner/vim-rzip", event = "BufEnter" },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function() require("leap").add_default_mappings() end,
  },
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  { "null-ls.nvim", enabled = false },
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
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        rainbow_delimiters = true,
      },
    },
  },
  { "github/copilot.vim", event = "InsertEnter", cmd = "Copilot" },
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
}
