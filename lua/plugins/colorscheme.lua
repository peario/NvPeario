--- Holds plugins which adds colorschemes
return {
  -- Nord
  {
    "shaunsingh/nord.nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },
}
