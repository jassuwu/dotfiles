-- nvim-lspconfig supplies cmd/filetypes/root_markers for each of these. Overrides,
-- if any, live in after/lsp/<name>.lua.
--
-- basedpyright, ruff, and rust_analyzer are enabled here even though their binaries
-- are not on PATH yet (GitHub was down during the rewrite). Neovim will warn and
-- skip them until the leftover installs in README.md land.
vim.lsp.enable({
  'lua_ls',
  'gopls',
  'vtsls',
  'tailwindcss',
  'basedpyright',
  'ruff',
  'clangd',
  'rust_analyzer',
  'jdtls',
  'taplo',
  'marksman',
  'jsonls',
  'yamlls',
  'html',
  'cssls',
})

-- Diagnostic signs can only be configured here; :sign-define was removed in 0.12.
-- Held in a local so <leader>l can put it back verbatim. Reading it off
-- vim.diagnostic.config() and writing it back turns it into a bare `true`,
-- which silently loses the prefix after one round trip.
local virtual_text = { prefix = '●' }

vim.diagnostic.config({
  virtual_text = virtual_text,
  virtual_lines = false, -- toggled on demand, see <leader>l
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  float = { source = true, header = '', prefix = '' },
})

-- virtual_lines is the native replacement for lsp_lines.nvim and covers most of what
-- trouble.nvim was used for. It is loud, so it toggles rather than defaulting on.
vim.keymap.set('n', '<leader>l', function()
  local lines = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
    virtual_lines = not lines,
    virtual_text = lines and virtual_text or false,
  })
end, { desc = 'Toggle diagnostic virtual lines' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Colon call as of 0.11; the dot form is deprecated and behaves differently.
    if client:supports_method('textDocument/documentColor') then
      -- On by default in 0.12, and noisy in Tailwind projects.
      vim.lsp.document_color.enable(false, ev.buf)
    end
  end,
})
