local h = require("helpers")


local M = {}



M.set = function(name)
  local parallax_folder = h.generate_parallax_folder(name)
  local profile = require("parallax" .. "." .. name)
  return profile.apply(parallax_folder)
end

return M
