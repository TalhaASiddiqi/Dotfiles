-- Customize None-ls sources
--
-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local python_cwd = function(params)
  local util = require "lspconfig/util"

  return util.root_pattern("requirements.txt", ".git")(params.bufname) or params.root
end

local is_yarn_berry = function(params)
  local util = require "lspconfig/util"
  return util.root_pattern ".yarnrc.yml"(params.bufname) or false
end

local ts_cwd = function(params)
  local util = require "lspconfig/util"

  return util.root_pattern("package.json", ".git", ".eslintrc")(params.bufname) or params.root
end

local ts_cmd = function(params)
  if not is_yarn_berry(params) then return params.command end

  return "yarn"
end

local eslint_d_config = {
  condition = function(utils)
    return utils.root_has_file "package.json"
      or utils.root_has_file ".eslintrc.json"
      or utils.root_has_file ".eslintrc.js"
  end,
  cwd = ts_cwd,
  dynamic_command = ts_cmd,
  prepend_extra_args = true,
  extra_args = function(params)
    if not is_yarn_berry(params) then return {} end

    return {
      "eslint",
    }
  end,
}

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    -- local none_ls = require "none-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.log_level = "debug"
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with {
        condition = function(utils)
          return utils.root_has_file "package.json"
            or utils.root_has_file ".prettierrc"
            or utils.root_has_file ".prettierrc.json"
            or utils.root_has_file ".prettierrc.js"
        end,
        dynamic_command = ts_cmd,
        prepend_extra_args = true,
        extra_args = function(params)
          if not is_yarn_berry(params) then return {} end

          return {
            "prettier",
          }
        end,
      },

      null_ls.builtins.formatting.black.with {
        cwd = python_cwd,
      },
      null_ls.builtins.formatting.isort.with {
        cwd = python_cwd,
      },
      null_ls.builtins.diagnostics.pylint.with {
        cwd = python_cwd,
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      },

      require("none-ls.code_actions.eslint").with(eslint_d_config),
      require("none-ls.diagnostics.eslint").with(eslint_d_config),
    }
    return config -- return final config table
  end,
}
