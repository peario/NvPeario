local types = require("libs.types")

---@class libs.highlights
local M = {}

---@class Group
---@field name string Name of the highlight group
---@field values any Values to assign to the specified highlight group
---@field ns_id? integer Optional namespace identifier
local Group = {}

--- Utility function to set one or more highlights.
---
--- Namespace id follows the fallback route of:
---  Within highlight group(s), ns_id -> this functions param, ns_id -> global namespace, 0
---@param highlight Group|Group[] Individual or multiple highlights to set/modify
---@param ns_id? integer Fallback to any unset namespace identifiers in the highlight group(s)
function M.set_hls(highlight, ns_id)
  local set_hl = vim.api.nvim_set_hl

  -- Set param `ns_id` to global namespace as fallback if not provided or invalid
  if ns_id == nil or type(ns_id) ~= "number" then
    ns_id = 0
  end

  if not types.is_array(highlight) then
    -- Make sure ns_id is not nil
    ns_id = (highlight.ns_id ~= nil and highlight.ns_id) or ns_id

    vim.notify(
      ("[S] Set highlight `%s` with value `%s`"):format(highlight.name, highlight.values),
      vim.log.levels.DEBUG,
      { title = "Highlights" }
    )
    set_hl(ns_id, highlight.name, highlight.values)
  else
    for _, v in ipairs(highlight) do
      ns_id = (v.ns_id ~= nil and v.ns_id) or ns_id

      vim.notify(
        ("[S] Set highlight `%s` with value `%s`"):format(highlight.name, highlight.values),
        vim.log.levels.DEBUG,
        { title = "Highlights" }
      )
      if types.is_table(v.values) then
        set_hl(ns_id, v.name, v.values)
      end
    end
  end
end

return M
