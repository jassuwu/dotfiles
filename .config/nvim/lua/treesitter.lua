-- The `main` branch is a deliberate, incompatible rewrite: setup({ ensure_installed }),
-- highlight = { enable = true } and indent = { enable = true } do not exist. The plugin
-- installs parsers; features are enabled with core APIs here.
require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Core already ships and auto-starts c, lua, markdown, markdown_inline, query, vim and
-- vimdoc. Everything else needs the plugin.
local ensure = {
  'lua', 'vim', 'vimdoc', 'query',
  'c', 'cpp',
  'go', 'gomod', 'gowork', 'gosum',
  'python', 'rust', 'java',
  'javascript', 'typescript', 'tsx', 'html', 'css',
  -- No `jsonc` parser exists on the main branch; jsonc filetypes use the json one.
  'json', 'yaml', 'toml',
  'markdown', 'markdown_inline', 'bash', 'regex',
  'diff', 'gitcommit', 'git_rebase',
}

local installed = require('nvim-treesitter.config').get_installed()
local missing = vim.iter(ensure)
  :filter(function(p)
    return not vim.tbl_contains(installed, p)
  end)
  :totable()
if #missing > 0 then
  require('nvim-treesitter').install(missing)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(ev)
    -- start() throws if no parser is installed for this filetype, which is normal.
    if not pcall(vim.treesitter.start, ev.buf) then
      return
    end
    -- Indentation is the one feature with no core equivalent. The quoting is
    -- load-bearing.
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Folding is per-window; the FileType autocmd's current window may not correspond to
-- the buffer being processed.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('treesitter-fold', { clear = true }),
  callback = function()
    if vim.treesitter.get_parser(0, nil, { error = false }) then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldlevel = 99
    end
  end,
})
