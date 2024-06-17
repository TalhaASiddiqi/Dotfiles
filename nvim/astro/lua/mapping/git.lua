return {
  n = {
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
  }
}
