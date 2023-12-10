local neovide_paste_keybinds = {
  [""] = {
    ["D-v"] = {
      "+p<CR>",
      noremap = true,
      silent = true,
    },
  },
  ["rest"] = {
    ["D-v"] = {
      "<CR>+",
      noremap = true,
      silent = true,
    },
  },
}

return {
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
}
