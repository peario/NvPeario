-- Lazy-loading, installing and (semi-)automatic management of:
--  LSP, DAPs, linters, formatters and other tools
return {
  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      -- Add LSP into `ensure_installed` to have them auto-install.
      -- This is not included by default in mason, but custom functionality.
      ensure_installed = {
        -- API
        --- Protobuf
        "buf", -- Linter & formatter
        "buf-language-server",
        -- Browsers
        "chrome-debug-adapter",
        "firefox-debug-adapter",
        -- C & C++
        "clangd", -- LSP
        "clang-format", -- Formatter
        "cpplint", -- Linter
        "codelldb", -- DAP :: Also applies to Rust and Zig
        -- CMake
        "cmakelang", -- Formatter
        "cmake-language-server",
        -- CSS
        "prettierd", -- Formatter
        "rustywind", -- Formatter
        "tailwindcss-language-server", -- LSP
        "stylelint", -- Linter
        "css-lsp", -- LSP
        "css-variables-language-server", -- LSP
        -- Docker
        "dockerfile-language-server", -- LSP
        "docker-compose-language-service", -- LSP
        -- GitHub
        "actionlint", -- Lint
        -- Go
        --- Formatters
        "goimports",
        "goimports-reviser",
        "golines",
        "gomodifytags",
        "gofumpt",
        "gotests",
        --- LSP
        "gopls",
        --- Linter
        "revive",
        --- DAP
        "delve",
        --- Utility
        "iferr",
        "impl",
        -- HTML
        "htmlhint", -- Linter
        "htmlbeautifier", -- Formatter
        "html-lsp",
        -- Javascript, Typescript, jsx, tsx
        "biome", -- Prettier and Eslint replacement
        "typescript-language-server",
        -- JSON
        "json-lsp",
        "fixjson", -- Formatter
        -- Lua
        "stylua", -- Formatter
        "selene", -- Linter
        "lua-language-server",
        -- Markdown
        "alex", -- Linter :: Catch insensitive writing
        "cbfmt", -- Formatter :: Codeblocks
        "glow", -- Utilitiy :: Preview markdown styled in CLI
        "marksman", -- LSP
        -- Nix
        "nil", -- LSP
        "nixpkgs-fmt", -- Formatter
        -- Python
        "ruff", -- Formatting/linting
        "ruff-lsp", -- LSP
        "debugpy", -- DAP
        -- Rust
        "rust-analyzer",
        -- Shells :: Bash, zsh, etc.
        "beautysh", -- Formatter
        "bash-debug-adapter", -- DAP
        "bash-language-server",
        -- SQL
        "sql-formatter", -- Formatter
        "sqls", -- LSP
        "sqlfluff", -- Linter
        -- Svelte
        "svelte-language-server",
        -- XML, SVG
        "xmlformatter",
        "lemminx", -- LSP
        -- templ :: go + html
        "templ",
        -- LaTeX
        "ltex-ls", -- LSP :: Grammar checker
        "texlab", -- LSP :: Everything else
        "latexindent", -- Formatter :: Beautify/tidy/format/indent
        -- Toml
        "taplo", -- LSP
        -- Yaml
        "yamlfmt",
        "yamllint",
        "yaml-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Custom command to install all listed in `opts.ensure_installed`
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("Mason")
          local mr = require("mason-registry")

          mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end)
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  -- Mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}
