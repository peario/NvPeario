--- Holds core plugins which improves the general nvim experience
return {
  -- Mappings UI
  { "folke/which-key.nvim" },
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
}
