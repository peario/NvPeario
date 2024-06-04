-- Set all options
require("config.options")

-- Register autocmds
require("config.autocmds")

-- Load all mappings, while avoid textlocks and other issues
vim.schedule(function()
  require("config.mappings")
end)
