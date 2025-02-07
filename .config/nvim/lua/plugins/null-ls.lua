return {
  -- null-ls is deprecated, so using the drop-in replacement, none-ls.
  -- "jose-elias-alvarez/null-ls.nvim"
  "nvimtools/none-ls.nvim",
  ft = {"go", "javascript", "javascriptreact", "typescript", "typescriptreact"},
  opts = function ()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    return {
      sources = {
        -- go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,

        -- ts
        null_ls.builtins.formatting.prettierd,
      },
      on_attach = function (client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    }
  end
}
