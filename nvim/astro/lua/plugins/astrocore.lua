---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        fillchars = { diff = "╱" },
      },
      g = {
        copilot_no_tab_map = true,
        copilot_assume_mapped = true,
      },
    },
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<Leader>gd"] = {
          ":DiffviewOpen<CR>",
          desc = "Git Diff current file",
        },
        ["<Leader>gc"] = {
          ":DiffviewFileHistory<CR>",
          desc = "Changes since commit",
        },
        ["<Leader>gC"] = {
          ":DiffviewFileHistory %<CR>",
          desc = "Changes since commit (file)",
        },
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            require("astrocore.buffer").close(0)
            if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
          end,
          desc = "Close buffer",
        },
        ["<C-d>"] = {
          "<C-d>zz",
          noremap = true,
          nowait = true,
          silent = true,
          desc = "Scroll down and center",
        },
        ["<C-u>"] = {
          "<C-u>zz",
          noremap = true,
          nowait = true,
          silent = true,
          desc = "Scroll down and center",
        },
        ["n"] = {
          "nzz",
          noremap = true,
          nowait = true,
          silent = true,
          desc = "Scroll down and center",
        },
        ["N"] = {
          "Nzz",
          noremap = true,
          nowait = true,
          silent = true,
          desc = "Scroll down and center",
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
  },
}
