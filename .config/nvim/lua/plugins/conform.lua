return {
  "stevearc/conform.nvim",
  ft = { "go", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  opts = {
    formatters_by_ft = {
      go = { "gofumpt", "goimports_reviser", "golines" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
