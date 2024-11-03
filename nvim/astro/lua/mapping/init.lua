local core = require "mapping.core"
local buffer = require "mapping.buffer"
local git = require "mapping.git"
local harpoon = require "mapping.harpoon"

local mappings = {}

local modes = { "n", "i" }
local files = {
  core,
  buffer,
  git,
  harpoon,
}

for _, mode in pairs(modes) do
  local mapping = {}
  for _, file in pairs(files) do
    if file[mode] then mapping = vim.tbl_deep_extend("error", mapping, file[mode]) end
  end
  mappings[mode] = mapping
end

return mappings
