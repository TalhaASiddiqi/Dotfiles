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
  options = {
    opt = { fillchars = { diff = "╱" } },
    g = {
      copilot_no_tab_map = true,
      copilot_assume_mapped = true,
    },
  },
  lsp = {
    setup_handlers = {
      efm = function(opts)
        local isort = require "efmls-configs.formatters.isort"
        local pylint = require "efmls-configs.linters.pylint"
        local black = require "efmls-configs.formatters.black"
        local eslint = require "efmls-configs.linters.eslint_d"
        local stylua = require "efmls-configs.formatters.stylua"
        local prettier = require "efmls-configs.formatters.prettier"
        prettier.formatCommand = "yarn prettier --stdin --stdin-filepath '${INPUT}' ${--range-start:charStart} "
          .. "${--range-end:charEnd} ${--tab-width:tabSize} ${--use-tabs:!insertSpaces}"
        pylint = vim.tbl_extend("force", pylint, {
          lintCommand = "pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
          lintFormats = { "%f:%l:%c:%t:%m" },
          lintOffsetColumns = 1,
          lintCategoryMap = {
            I = "H",
            R = "I",
            C = "I",
            W = "W",
            E = "E",
            F = "E",
          },
          lintIgnoreExitCode = true,
        })

        local languages = {
          -- javascript = { eslint, prettier },
          -- javascriptreact = { eslint, prettier },
          typescript = { eslint, prettier },
          typescriptreact = { eslint, prettier },
          lua = { stylua },
          python = { isort, black, pylint },
        }

        local efmls_config = {
          filetypes = vim.tbl_keys(languages),
          settings = { rootMarkers = { ".git/" }, languages = languages },
          root_dir = require("lspconfig.util").root_pattern("tscofig.json", "yarn.lock", "package.json", ".git"),
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
            codeAction = true,
          },
        }
        print(vim.inspect(opts))
        require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
          on_attach = require("astronvim.utils.lsp").on_attach,
          cmd = {
            "efm-langserver",
            -- "-loglevel",
            -- "10",
            -- "-logfile",
            -- "/Users/talha/Desktop/efm.log",
          },
        }))
      end,
    },
    config = {
      -- pylsp = {
      --   root_dir = function(arg) return require("lspconfig.util").find_git_ancestor(arg) end,
      --   settings = {
      --     pylsp = {
      --       configurationSources = {},
      --       plugins = {
      --         pyflakes = { enabled = false },
      --         mccabe = { enabled = false },
      --         pylint = { enabled = false },
      --         yapf = { enabled = false },
      --         autopep8 = { enabled = false },
      --         flake8 = { enabled = false },
      --         pycodestyle = { enabled = false },
      --       },
      --     },
      --   },
      -- },
    },
    formatting = {
      async = true,
      disabled = { "pylsp", "tsserver" },
      timeout_ms = 50000,
    },
  },
  plugins = {
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
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
  },
  colorscheme = "catppuccin-mocha",
  mappings = {
    n = {
      ["<leader>gd"] = {
        ":DiffviewOpen<CR>",
        desc = "Git Diff current file",
      },
      ["<leader>gc"] = {
        ":DiffviewFileHistory<CR>",
        desc = "Changes since commit",
      },
      ["<leader>gC"] = {
        ":DiffviewFileHistory %<CR>",
        desc = "Changes since commit (file)",
      },
    },
    i = {
      ["<D-a>"] = {
        'copilot#Accept("<CR>")',
        noremap = true,
        silent = true,
        expr = true,
        replace_keycodes = false,
      },
      ["<D-]>"] = {
        "copilot#Next()",
        noremap = true,
        silent = true,
        expr = true,
        replace_keycodes = false,
      },
      ["<D-[>"] = {
        "copilot#Previous()",
        noremap = true,
        silent = true,
        expr = true,
        replace_keycodes = false,
      },
    },
  },
}
