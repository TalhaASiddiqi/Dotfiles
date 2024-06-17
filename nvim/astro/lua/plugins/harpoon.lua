local update_maps = function()
  local harpoon_mark = require "harpoon.mark"
  local quick_jumps = {}
  for i = 1, 9, 1 do
    local mark_file = harpoon_mark.get_marked_file(i)

    local key = "<leader>h" .. tostring(i)
    if mark_file == nil then
      quick_jumps[key] = nil
    else
      local short_name = mark_file.filename
      local tail = vim.fn.fnamemodify(short_name, ":t")
      local head = vim.fn.fnamemodify(short_name, ":h")
      local second_last_tail = vim.fn.fnamemodify(head, ":t")
      local name_to_show = ""
      if tail == second_last_tail then
        name_to_show = tail
      else
        name_to_show = second_last_tail .. "/" .. tail
      end
      quick_jumps[key] = {
        function() require("harpoon.ui").nav_file(i) end,
        name_to_show,
      }
    end
  end

  require("which-key").register(quick_jumps)
end

return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- lazy = false,
    config = function()
      require("harpoon").setup()
      local harpoon_mark = require "harpoon.mark"
      harpoon_mark.on("changed", update_maps)
      update_maps()
    end,
  },
}
