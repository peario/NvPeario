--- Holds plugins related to treesitter and syntax highlighting
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
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
        "jsonc",
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
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },
}
