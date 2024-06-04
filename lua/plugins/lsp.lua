-- Rather than containing specific LSP (which `mason.lua` handles),
-- this file holds plugins responsible for a specific type of utility or in a
-- certain type of area, i.e `b0o/schemastore.nvim` for autocompleting json and yaml files
return {
  -- Customize LSP server
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = false,
        dependencies = { "nvim-lspconfig" },
      },
      { "folke/lazydev.nvim" },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      require("config.lsp")
    end,
  },
}
