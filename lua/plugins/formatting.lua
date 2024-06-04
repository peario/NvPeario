-- https://www.lazyvim.org/plugins/formatting
--- FORMATTING via conform.nvim
return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = true,
  cmd = "ConformInfo",
  ---@class ConformOpts
  opts = {
    -- Settings used when formatting via conform.nvim
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_fallback = true,
    },
    -- Specify which formatters to use for each filetype.
    -- The lsp server must be one of: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    -- Having `{ { ... }, ...}` in the list of formatters uses the first available formatter within the `{ ... }` list.
    ---@type table<string, conform.FormatterUnit[]>
    formatters_by_ft = {
      bash = { "beautysh" },
      c = { "clang-format" },
      cmake = { "cmakelang" },
      cpp = { "clang-format" },
      css = { "prettierd", "rustywind" },
      go = { "goimports", "goimports-reviser", "golines", "gomodifytags", "gofumpt", "gotests" },
      gohtml = { "rustywind" },
      gohtmltmpl = { "rustywind" },
      hbs = { "rustywind" },
      html = { "htmlbeautifier", "rustywind" },
      javascript = { { "biome", "prettierd" }, "rustywind" },
      javascriptreact = { { "biome", "prettierd" }, "rustywind" },
      json = { { "fixjson", "biome" } },
      jsonc = { { "fixjson", "biome" } },
      jsx = { { "biome", "prettierd" }, "rustywind" },
      lua = { "stylua" },
      markdown = { "prettierd", "cbfmt" },
      nix = { "nixpkgs-fmt" },
      postcss = { "prettierd", "rustywind" },
      protobuf = { "buf" },
      python = { "ruff" },
      rust = { "rust_analyzer" },
      sass = { "prettierd", "rustywind" },
      scss = { "prettierd", "rustywind" },
      sh = { "beautysh" },
      sql = { "sql-formatter" },
      svelte = { "svelte-language-server", "rustywind" },
      svg = { "xmlformatter" },
      templ = { "tmpl", "rustywind" },
      tex = { "latexindent" },
      toml = { "taplo" },
      typescript = { { "biome", "prettierd" }, "rustywind" },
      typescriptreact = { { "biome", "prettierd" }, "rustywind" },
      xml = { "xmlformatter" },
      yaml = { { "yamlfmt", "prettierd" } },
      zsh = { "beautysh" },
    },
    -- These options will be merged with the builtin formatters
    -- You can also define any custom formatters here.
    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    formatters = {
      injected = {
        options = {
          ignore_errors = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
