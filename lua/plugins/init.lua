--- Holds core plugins which improves the general nvim experience
return {
  -- Manage global or project-local settings
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
  },
  -- Better and faster `folke/neodev.nvim`
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "luvit-meta/library",
      },
    },
  },
  -- Optional `vim.uv` typings
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
  -- A collection of useful libs
  { "nvim-lua/plenary.nvim" },
  -- Mappings UI
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    event = "VeryLazy",
    key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
}
