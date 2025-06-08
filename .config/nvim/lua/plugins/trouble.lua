return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        function()
          require("trouble").toggle("diagnostics")
        end,
        desc = "Document Diagnostics (Trouble)",
      },
    },
  },
}
