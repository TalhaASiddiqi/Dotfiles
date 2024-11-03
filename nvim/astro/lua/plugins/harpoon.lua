local update_maps = function()
  local harpoon = require "harpoon"
  local list = harpoon:list()

  local quick_jumps = {}
  local len = list:length()
  for i = 1, 9, 1 do
    local mark_file = list:get(i)

    local key = "<leader>h" .. tostring(i)
    if mark_file == nil or i > len then
      table.insert(quick_jumps, {
        key,
        function() end,
        hidden = true,
      })
    else
      local short_name = mark_file.value
      local tail = vim.fn.fnamemodify(short_name, ":t")
      local head = vim.fn.fnamemodify(short_name, ":h")
      local second_last_tail = vim.fn.fnamemodify(head, ":t")
      local name_to_show = ""
      if tail == second_last_tail then
        name_to_show = tail
      else
        name_to_show = second_last_tail .. "/" .. tail
      end
      table.insert(quick_jumps, { key, function() list:select(i) end, desc = name_to_show })
    end
  end

  require("which-key").add(quick_jumps)
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- lazy = false,
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {}
      harpoon:extend {
        ADD = function() vim.schedule(update_maps) end,
        REMOVE = function() vim.schedule(update_maps) end,
        REORDER = function() vim.schedule(update_maps) end,
        UI_CREATE = function(opts)
          local bufnr = opts.bufnr

          vim.api.nvim_create_autocmd({ "BufUnload", "BufWritePost" }, {
            buffer = bufnr,
            callback = function()
              local timer = vim.loop.new_timer()
              timer:start(100, 0, vim.schedule_wrap(update_maps))
            end,
          })
        end,
      }
      update_maps()
    end,
  },
}
