local h = require("helpers")

local M = {}
local dimmer = { brightness = 0.1 }
M.apply = function(parallax_folder)
  return {
    -- This is the deepest/back-most layer. It will be rendered first
    {
      source = {
        File = parallax_folder .. 'bg-1.png',
      },
      -- The texture tiles vertically but not horizontally.
      -- When we repeat it, mirror it so that it appears "more seamless".
      -- An alternative to this is to set `width = "100%"` and have
      -- it stretch across the display
      repeat_x = 'Mirror',
      hsb = dimmer,
      -- When the viewport scrolls, move this layer 10% of the number of
      -- pixels moved by the main viewport. This makes it appear to be
      -- further behind the text.
      attachment = { Parallax = 0.1 },
    },
    -- Subsequent layers are rendered over the top of each other
    {
      source = {
        File = parallax_folder .. 'overlay-1.png',
      },
      width = '100%',
      repeat_x = 'NoRepeat',

      -- position the spins starting at the bottom, and repeating every
      -- two screens.
      vertical_align = 'Bottom',
      repeat_y_size = '200%',
      hsb = dimmer,

      -- The parallax factor is higher than the background layer, so this
      -- one will appear to be closer when we scroll
      attachment = { Parallax = 0.2 },
    },
    {
      source = {
        File = parallax_folder .. 'overlay-2.png',
      },
      width = '100%',
      repeat_x = 'NoRepeat',

      -- start at 10% of the screen and repeat every 2 screens
      vertical_offset = '10%',
      repeat_y_size = '200%',
      hsb = dimmer,
      attachment = { Parallax = 0.3 },
    },
    {
      source = {
        File = parallax_folder .. 'overlay-3.png',
      },
      width = '100%',
      repeat_x = 'NoRepeat',

      vertical_offset = '30%',
      repeat_y_size = '200%',
      hsb = dimmer,
      attachment = { Parallax = 0.4 },
    },
    {
      source = {
        File = parallax_folder .. 'overlay-4.png',
      },
      width = '100%',
      repeat_x = 'NoRepeat',

      vertical_offset = '50%',
      repeat_y_size = '150%',
      hsb = dimmer,
      attachment = { Parallax = 0.5 },
    },
  }
end

return M