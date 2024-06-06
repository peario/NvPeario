local map = require("libs.keybinds")

--- Keybinds ---
-- Editing
map.set("n", "<C-a>", "gg<S-v>G", "Select all")
map.set("n", "U", "<cmd>redo<CR>", "Redo")

-- Movement
map.set("n", "j", "gj", "Go down, ignore `wrap`")
map.set("n", "k", "gk", "Go up, ignore `wrap`")

-- QoL
map.set("n", ";", ":", "Command mode alias")
map.set("i", "jk", "<ESC>", "Escape alias")
map.set("n", "<leader>s", "<cmd>w<CR>", "Save")
