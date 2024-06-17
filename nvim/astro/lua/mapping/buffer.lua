return {
  n = {
    -- navigate buffer tabs with `H` and `L`
    L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
    H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

    -- mappings seen under group name "Buffer"
    ["<Leader>b"] = { desc = "Buffers" },
    ["<Leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astrocore.buffer").close(0)
        if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    ["<Leader>bD"] = {
      function()
        require("astroui.status.heirline").buffer_picker(
          function(bufnr) require("astrocore.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
  }
}
