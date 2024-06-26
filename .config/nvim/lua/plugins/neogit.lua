return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    "nvim-telescope/telescope.nvim",
  },
  config = function ()
    local neogit = require("neogit")
    neogit.setup({
      kind = "split",
      -- needs nerd font to work correctly, comment out otherwise
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    })

    vim.keymap.set("n", "<leader>g", neogit.open, {})
  end,
}
