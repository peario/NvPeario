---@class libs.statusline.generate
local M = {}

---@class ThemeAttributes
---@field fg string
---@field fg_light string
---@field bg string
---@field bg_light string
---@field gray string
---@field gray_light string
---@field cyan string
---@field teal string
---@field blue string
---@field blue_dark string
---@field green string
---@field green_light string
---@field red string
---@field red_light string
---@field red_dark string
---@field pink string
---@field pink_dark string
---@field orange string
---@field purple string
---@field purple_light string
local ThemeAttributes = {}

--- Not strictly for the custom statusline
--- Works as append to original; append -> original.
---
--- TODO: Move to a more appropriate libs section
---@param original table Which table to append to
---@param append table Which table to append from
M.append_to_table = function(original, append)
  if type(original) ~= "table" then
    return
  end

  for k, v in pairs(append) do
    original[k] = v
  end
end

--- Specifically used for the custom statusline
---@param mode string Name of (VIM-)mode, eg. INSERT or NORMAL
---@param color string Color to paint the mode in
---@param theme ThemeAttributes Allowed theme attributes
---@return table
M.mode_hl = function(mode, color, theme)
  return {
    ["St_" .. mode .. "Mode"] = { fg = theme.bg, bg = color, bold = true },
    ["St_" .. mode .. "ModeSep"] = { fg = color, bg = theme.gray },
  }
end

--- Specifically used for the custom statusline
---@param name string Case-sensitive name of highlight
---@param opts { fg?: string, bg?: string, bold?: boolean } Common options
---@return table
M.hl = function(name, opts)
  return { ["St_" .. name] = opts }
end

return M
