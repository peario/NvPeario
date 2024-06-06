--- Holds plugins which are used for sharing code, snippets, etc.
return {
  -- Screenshot tool
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    opts = {
      to_clipboard = true,
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
      wslclipboard = "auto",
    },
  },
}
