return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      local utils = require "heirline.utils"

      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.git_diff {
          surround = { separator = "left" },
        },
        status.component.diagnostics(),
        {
          init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
          status.component.file_info { surround = false, filetype = false, filename = false, file_modified = false },
          {
            init = function(self)
              self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
              if self.lfilename == nil or self.lfilename == "" then self.lfilename = "[No Name]" end
            end,
            hl = { fg = utils.get_highlight("Directory").fg },
            flexible = 2,
            {
              provider = function(self) return self.lfilename end,
            },
            {
              provider = function(self) return vim.fn.pathshorten(self.lfilename) end,
            },
          },
        },
        -- status.component.fill(),
        status.component.fill(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav {
          percentage = false,
        },
        -- status.component.mode { surround = { separator = "right" } },
      }

      return opts
    end,
  },
}
