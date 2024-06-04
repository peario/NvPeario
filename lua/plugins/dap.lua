--- Holds plugins used for debugging
return {
  -- DAP
  { "mfussenegger/nvim-dap" },
  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
}
