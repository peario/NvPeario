---@class libs.keybinds
local M = {}

--- Sort and filter the values of label and keybind desc option.
--- Used for `require("libs.keybinds"):set()`.
---@param label? string Explicit description used for label
---@param tbl? string While named tbl, it's aimed at the desc field within keybind options
---@return string? #If valid returns first in order of `label` -> `tbl` -> "". If invalid, goes to the next as fallback.
function Resolve_label(label, tbl)
  if label ~= (nil or "") then
    return label
  elseif tbl ~= (nil or "") then
    return tbl
  end

  return ""
end

---@alias VimKeymapMode
---|'"n"' # Normal Mode
---|'"x"' # Visual Mode Keymaps
---|'"s"' # Select Mode
---|'"v"' # Equivalent to "xs"
---|'"o"' # Operator-pending mode
---|'"i"' # Insert Mode
---|'"c"' # Command-Line Mode
---|'"l"' # Insert, Command-Line and Lang-Arg
---|'"t"' # Terminal Mode
---|'"!"' # Equivalent to Vim's `:map!`, which is equivalent to '"ic"'
---|'""'  # Equivalent to Vim's `:map`, which is equivalent to "nxso"

--- Create keybinds in a uniform way.
--- The param `desc` and attribute `desc` will merge, with param overwriting attribute.
---@param mode VimKeymapMode|VimKeymapMode[] In which mode(s) does the keybind trigger?
---@param key string Which keys to press to trigger the result field
---@param result string|fun() What happens when the keybind is activated?
---@param label string? Alias for description and is used as label by `which-key`, what does the keybind do?
---@param attrs { noremap?: boolean, nowait?: boolean, silent?: boolean, unique?: boolean, desc?: string, other?: ... }? Attributes which can be assigned to a keybind
function M.set(mode, key, result, label, attrs)
  attrs = attrs or { noremap = true, silent = true }
  label = Resolve_label(label, attrs.desc)

  -- Set label to the attrs
  attrs.desc = label

  vim.keymap.set(mode, key, result, attrs)
end

return M
