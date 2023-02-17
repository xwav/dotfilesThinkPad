local util = require("gruvbox-baby.util")

local the_palette = {
  dark0 = "#0d0e0f",
  dark = "#202020",
  foreground = "#ebdbb2",
  background = "#282828",
  background_dark = "#000000",
  background_light = "#1c1918",
  medium_gray = "#504945",
  comment = "#c9bfb7",
  gray = "#DEDEDE",
  soft_yellow = "#6aa84f", --color of function green
  soft_green = "#D4879C", --color of text pink
  bright_yellow = "#fabd2f",
  orange = "#823908",
  red = "#7fa2ac", --color of loop blue
  error_red = "#cc241d",
  magenta = "#b16286",
  pink = "#D4879C",
  light_blue = "#eebd35", --color of variables light yellow also color of NORMAL field at statusbar
  dark_gray = "#83a598",
  blue_gray = "#eebd35", --color of paths and flags lighte yellow  
  forest_green = "#689d6a",
  clean_green = "#8ec07c",
  milk = "#E7D7AD",
  none = "NONE",
}

-- these are backgrounds
the_palette.diff = {
  add = "#26332c",
  change = "#273842",
  delete = "#572E33",
  text = "#314753",
}

local original_palette = vim.tbl_extend("force", the_palette, {
  foreground = "#fbf1c7",
  soft_green = "#b8bb26",
  forest_green = "#8bb26",
  soft_yellow = "#fabd2f",
  light_blue = "#83a598",
  magenta = "#d3869b",
  orange = "#fe8019",
  gray = "#928374",
  comment = "#928374",
})

local M = {}

function M.config(config)
  config = config or require("gruvbox-baby.config")
  local colors
  if config.use_original_palette then
    colors = original_palette
  else
    colors = the_palette
  end

  local intensity_map = {
    ["dark"] = {
      dark = colors.dark0,
      background = colors.background_dark,
      background_dark = util.darken(colors.background_dark, 0.8),
    },
    ["medium"] = {
      background = colors.background,
      background_dark = util.darken(colors.background, 0.9),
    },
    ["soft"] = {
      background = colors.background_light,
      background_dark = util.darken(colors.background_light, 0.8),
      background_light = util.lighten(colors.background_light, 0.95),
    },
    ["soft_flat"] = {
      background = colors.background_light,
      background_dark = colors.background_light,
      background_light = util.lighten(colors.background_light, 0.95),
    },
  }

  local background = config.background_color or colors.background
  if intensity_map[background] then
    colors = vim.tbl_extend("force", colors, intensity_map[background])
  end

  if config.transparent_mode then
    local transparent = {
      background = colors.none,
      background_dark = colors.none,
    }
    colors = vim.tbl_extend("force", colors, transparent)
  end

  if config.color_overrides then
    for override_color, new_color in pairs(config.color_overrides) do
      colors[override_color] = new_color
    end
  end
  return colors
end

return M
