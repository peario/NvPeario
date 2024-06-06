--- Holds plugins which doesn't fit into a clear category
return {
  -- Discord rich presence
  {
    "andweeb/presence.nvim",
    config = function(_, opts)
      require("presence").setup(opts)
    end,
  },
  -- TMUX integration
  {
    "christoomey/vim-tmux-navigator",
    laze = false,
    config = function()
      local map = require("libs.keybinds")

      map.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", "Window left")
      map.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", "Window right")
      map.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", "Window down")
      map.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", "Window up")
    end,
  },
  -- Disable various options, plugins, etc. in larger files
  -- to improve performance
  { "LunarVim/bigfile.nvim" },
}
