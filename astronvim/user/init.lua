-- Helper function for transparency formatting
local alpha = function() return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8)) end
if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font:h14"
  vim.g.transparency = 0.95
  vim.g.neovide_transparency = 0.0
  vim.g.neovide_background_color = "#1e1e2e" .. alpha()
end

return {
  options = {
    opt = { fillchars = { diff = "╱" } },
    g = {
      copilot_no_tab_map = true,
      copilot_assume_mapped = true,
    },
  },
  colorscheme = "catppuccin-mocha",
}
