-- cmd, filetypes and root_dir all come from nvim-lspconfig. This is the delta only.
return {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = { unusedparams = true, shadow = true },
    },
  },
}
