---@param name string Name of augroup
local function augroup(name)
  return vim.api.nvim_create_augroup("peario_" .. name, { clear = true })
end

-- Alias for autocmd
local autocmd = vim.api.nvim_create_autocmd

autocmd("ModeChanged", {
  pattern = { "i", "v", "n" },
  group = augroup("DiagnosticMode"),
  callback = function(args)
    local bufnr = args.buf
    local is_attached = vim.lsp.buf_is_attached(bufnr, 1)
    local mode = vim.fn.mode()
    if is_attached and mode == "n" then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end,
})

autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
