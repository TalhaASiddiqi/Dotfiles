local mappings = {
  -- Harpoon (by PrimeDaddy)
  ["<Leader>h"] = {
    function() end,
    name = "Harpoon",
    desc = "Harpoon",
  },
  ["<Leader>hh"] = {
    function() require("harpoon.mark").add_file() end,
    desc = "Add harpoon mark",
  },
  ["<Leader>hg"] = {
    function() require("harpoon.ui").toggle_quick_menu() end,
    desc = "Toggle harpoon quick menu",
  },
}

return {
  n = mappings,
}
