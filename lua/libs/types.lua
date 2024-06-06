---@class libs.types
local M = {}

---@class HighlightDefMap
---@field fg string|"fg"|"bg" color name or "#RRGGBB"
---@field bg string|"fg"|"bg" color name or "#RRGGBB"
---@field sp string|"fg"|"bg" color name or "#RRGGBB"
---@field blend number a number between 0 and 100
---@field bold boolean
---@field standout boolean
---@field undercurl boolean
---@field underdouble boolean
---@field underdotted boolean
---@field underdashed boolean
---@field strikethrough boolean
---@field italic boolean
---@field reverse boolean
---@field nocombine boolean
---@field link string name of another highlight group to link to
---@field default boolean don't override existing definition
---@field ctermfg number sets foreground of cterm color
---@field ctermbg number sets background of cterm color
---@field cterm string attribute map, like highlight-args. If not set, cterm attributes will match those from the attribute map documented above
---@field force boolean if true force update the highlight group when it exists
M.HighlightDefMap = {}

--- Check if given value is an array.
--- Source: https://stackoverflow.com/a/52697380
---@param obj any
function M.is_array(obj)
  if type(obj) ~= "table" then
    return false
  end

  -- Objects always return empty size
  if #obj > 0 then
    return true
  end

  -- Only object can have empty length with elements inside
  for _, _ in pairs(obj) do
    return false
  end

  -- If no elements it can be array and not at the same time
  return true
end

function M.is_table(obj)
  return type(obj) == "table"
end

return M
