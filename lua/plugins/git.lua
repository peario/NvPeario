--- Holds plugins related to git primarily
return {
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = require("libs.keybinds")

        map.set("n", "<leader>rh", gs.reset_hunk, "Reset hunk", { buffer = bufnr })
        map.set("n", "<leader>ph", gs.preview_hunk, "Preview hunk", { buffer = bufnr })
        map.set("n", "<leader>gb", gs.blame_line, "Blame line", { buffer = bufnr })
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
