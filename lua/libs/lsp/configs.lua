---@class libs.lsp.configs
local M = {}

-- For setting keymaps
local map = require("libs.keybinds")

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
  map.set("n", "gD", vim.lsp.buf.declaration, "Go to declaration", { buffer = bufnr })
  map.set("n", "gd", vim.lsp.buf.definition, "Go to definition", { buffer = bufnr })
  map.set("n", "gi", vim.lsp.buf.implementation, "Go to implementation", { buffer = bufnr })
  map.set("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help", { buffer = bufnr })
  map.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder", { buffer = bufnr })
  map.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", { buffer = bufnr })

  map.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders", { buffer = bufnr })

  map.set("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition", { buffer = bufnr })

  map.set("n", "<leader>ra", function()
    require("libs.lsp.renamer")()
  end, "NvRenamer", { buffer = bufnr })

  map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action", { buffer = bufnr })
  map.set("n", "gr", vim.lsp.buf.references, "Show references", { buffer = bufnr })

  -- setup signature popup
  if client.server_capabilities.signatureHelpProvider then
    require("libs.lsp.signature").setup(client, bufnr)
  end
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  require("libs.lsp")

  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end

return M
