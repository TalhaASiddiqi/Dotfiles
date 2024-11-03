local mappings = {
  -- ["<Leader>h"] = {
  --   name = "Harpoon",
  -- },
  ["<Leader>hh"] = {
    function() require("harpoon"):list():add() end,
    desc = "Add harpoon mark",
  },
  ["<Leader>hg"] = {
    function()
      local harpoon = require "harpoon"
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Toggle harpoon quick menu",
  },
}

return {
  n = mappings,
}
