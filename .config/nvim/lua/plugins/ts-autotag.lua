
return {
  -- null-ls is deprecated, so using the drop-in replacement, none-ls.
  -- "jose-elias-alvarez/null-ls.nvim"
  "windwp/nvim-ts-autotag",
  ft = {"javascript", "javascriptreact", "typescript", "typescriptreact", "html"},
  config = function ()
    require("nvim-ts-autotag").setup()
  end
}
