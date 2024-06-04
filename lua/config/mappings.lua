-- Alias for write keybinds
local map = vim.keymap

--- Easily add/modify attributes to a keybind.
--- Returns a table literal of keymap options
---@param label? string Add a label (description) to a keybind
---@param opts? { nowait?: boolean, silent?: boolean, unique?: boolean } Optional additional attributes
local function attrs(label, opts)
  label = label or ""
  opts = opts or { noremap = true, silent = true }

  if label ~= (nil or "") then
    opts["desc"] = label
  end

  return opts
end

--- Keybinds ---
-- Editing
map.set("n", "<C-a>", "gg<S-v>G", attrs("Select all"))
map.set("n", "U", "<cmd>redo<CR>", attrs("Redo"))

-- Movement
map.set("n", "j", "gj", attrs("Go down, ignore `wrap`"))
map.set("n", "k", "gk", attrs("Go up, ignore `wrap`"))

-- QoL
map.set("n", ";", ":", attrs("Command mode alias"))
map.set("i", "jk", "<ESC>", attrs("Escape alias"))
map.set("n", "<leader>s", "<cmd>w<CR>", attrs("Save"))
map.set("n", "<leader>S", "<cmd>w!<CR>", attrs("Save (force)"))
