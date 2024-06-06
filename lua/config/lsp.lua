local configs = require("libs.lsp.configs")

--- Holds LSP servers which doesn't require extensive configurations
---@type string[]
local servers = {
  -- C, C++
  clangd = {},
  -- CMake
  cmake = {}, -- "cmake-language-server"
  -- CSS
  cssls = {}, -- "css-lsp"
  css_variables = {}, -- "css-variables-language-server"
  tailwindcss = {}, -- "tailwindcss-language-server"
  -- Docker, Docker compose
  dockerls = {}, -- "dockerfile-language-server"
  docker_compose_language_service = {}, -- "docker-compose-language-service"
  -- Go
  gopls = {},
  -- HTML
  html = {}, -- "html-lsp"
  -- Javascript, typescript
  tsserver = {}, -- "typescript-language-server"
  -- JSON
  jsonls = {}, -- "json-lsp"
  -- Lua
  lua_ls = {}, -- "lua-language-server"
  -- Markdown
  marksman = {},
  -- Python
  ruff_lsp = {}, -- Use "ruff" for formatting/linting
  -- Rust
  rust_analyzer = {},
  -- Shells :: Bash
  bashls = {}, -- "bash-language-server"
  -- SQL
  sqls = {},
  -- Svelte
  svelte = {}, -- "svelte-language-server"
  -- XML, SVG
  lemminx = {},
  -- Templ :: Mix of Go and HTML
  templ = {},
  -- LaTeX
  ltex = {}, -- "ltex-ls"
  texlab = {},
  -- Toml
  taplo = {},
  -- Yaml
  yamlls = {}, -- "yaml-language-server"
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
