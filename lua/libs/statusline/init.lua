local helper = require("libs.statusline.helper")

---@class libs.statusline
---@field helper libs.statusline.helper
---@field colors libs.statusline.colors
local M = {}

local sep_style = "default"
local default_sep_icons = {
  default = { left = "", right = "" },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = separators["right"]

M.mode = function()
  if not helper.is_activewin() then
    return ""
  end

  local modes = helper.modes

  local m = vim.api.nvim_get_mode().mode

  local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1]
  local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
  return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
end

M.file = function()
  local x = helper.file()
  local name = " " .. x[2] .. " "
  return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
end

M.git = function()
  return "%#St_gitIcons#" .. helper.git()
end

M.lsp_msg = function()
  return "%#St_LspMsg#" .. helper.lsp_msg()
end

M.diagnostics = helper.diagnostics

M.lsp = function()
  return "%#St_Lsp#" .. helper.lsp()
end

M.cwd = function()
  local icon = "%#St_cwd_icon#" .. "󰉋 "
  local name = vim.loop.cwd()
  name = "%#St_cwd_text#" .. " " .. (name and name:match("([^/\\]+)[/\\]*$") or name) .. " "
  return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. icon .. name)) or ""
end

M.cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %p %% "
M["%="] = "%="

return function()
  return helper.generate(M)
end
