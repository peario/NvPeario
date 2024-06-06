---@param name string Name of augroup
local function augroup(name)
  return vim.api.nvim_create_augroup("peario_" .. name, { clear = true })
end

-- Alias for autocmd
local autocmd = vim.api.nvim_create_autocmd

-- Failsafe for mode change where the custom statusline disappears
autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      vim.cmd("redraw")
    end)
  end,
})

-- Auto-format buffer when saving
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- redraw dashboard on VimResized event
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if vim.bo.filetype == "nvdash" then
      vim.opt_local.modifiable = true
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
      -- require("nvchad.nvdash").open()
    elseif vim.bo.filetype == "nvcheatsheet" then
      vim.cmd("bw")
      -- require("nvchad.cheatsheet." .. config.cheatsheet.theme)()
    end
  end,
})

if vim.version().minor >= 10 then
  vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(args)
      if string.find(args.match, "end") then
        vim.cmd("redrawstatus")
      end
      vim.cmd("redrawstatus")
    end,
  })
end
