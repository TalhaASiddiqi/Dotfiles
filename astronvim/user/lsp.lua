return {
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
}
