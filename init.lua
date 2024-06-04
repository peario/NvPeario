-- Essentials
vim.g.mapleader = " "
vim.g.builtin_lsp = true
vim.opt.termguicolors = true

-- Disable providers for faster startup
local providers = { "python3", "perl", "ruby", "node" }
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Plugins
vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("libs.plugin").lazy_file()

require("lazy").setup("plugins", {
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "nord" },
  },
  checker = {
    -- Automatically check for plugin updates
    enabled = true,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load everything else
require("config")
