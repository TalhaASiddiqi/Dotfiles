local mappings = {
  n = {

    ["<Leader>fg"] = {
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end
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
}


return mappings
