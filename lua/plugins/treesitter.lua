--- Holds plugins related to treesitter and syntax highlighting
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      sync_install = true,
      ensure_installed = {
        -- high level
        "cpp",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "java",
        "javascript",
        "lua",
        "python",
        "typescript",
        -- low level
        "c",
        "rust",
        -- web, mobile, desktop
        "css",
        "dart",
        "html",
        "http",
        "svelte",
        "templ",
        -- scripts
        "fish",
        "bash",
        -- configs & build tools
        "dockerfile",
        "json",
        "make",
        "nix",
        "sql",
        "tmux",
        "toml",
        "vim",
        "xml",
        "yaml",
        -- documentation and writing
        "jsdoc",
        "latex",
        "luadoc",
        "vimdoc",
        -- other
        "comment",
        "diff",
        "git_config",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "regex",
      },
    },
  },
}
