local LazyUtil = require("lazy.core.util")

---@class libs
---@field keybinds libs.keybinds
---@field plugin libs.plugin
---@field lsp_configs libs.lsp.configs
---@field highlights libs.highlights
---@field types libs.types
---@field statusline libs.statusline
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("libs.util." .. k)
    return t[k]
  end,
})

-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.uv.new_timer()
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").spec.plugins[name]

  if not plugin then
    return {}
  end

  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

---@param name string
---@return boolean
function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return (Config.plugins[name] and Config.plugins[name]._.loaded) ~= nil
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end
