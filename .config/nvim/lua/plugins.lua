-- PackChanged must be registered BEFORE the first vim.pack.add() call: vim.pack has
-- no `build` spec key, install-time hooks fire during add(), and a handler registered
-- afterwards never runs. The failure mode is parsers silently never building.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build', { clear = true }),
  callback = function(ev)
    if ev.data.kind == 'delete' then
      return
    end
    if ev.data.spec.name == 'nvim-treesitter' then
      -- During init.lua sourcing the plugin is on rtp but its plugin/ files are not
      -- yet loaded, so :TSUpdate would not exist without this packadd.
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-mini/mini.surround' },
  { src = 'https://github.com/nvim-mini/mini.ai' },
  { src = 'https://github.com/nvim-mini/mini.pairs' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/jassuwu/lichen' },
})

-- Colorscheme first so later highlight overrides stick.
vim.cmd.colorscheme('lichen')

require('mini.surround').setup()
require('mini.ai').setup()
require('mini.pairs').setup()
require('nvim-ts-autotag').setup()

require('oil').setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
})

require('gitsigns').setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
})

require('fzf-lua').setup({ 'default-title' })

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'goimports', 'gofumpt' },
    javascript = { 'biome' },
    javascriptreact = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    json = { 'biome' },
    jsonc = { 'biome' },
    css = { 'prettier' },
    scss = { 'prettier' },
    html = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    toml = { 'taplo' },
    -- shfmt has no zsh support, so .zshrc is deliberately absent here.
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    python = { 'ruff_fix', 'ruff_format' },
    rust = { 'rustfmt' },
  },
  format_on_save = { lsp_format = 'fallback', timeout_ms = 1000 },
})
