return {
  "sindrets/diffview.nvim",
  config = function ()
    local diffview = require("diffview")
    diffview.setup({
      use_icons = false,
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
    })
  end
}
