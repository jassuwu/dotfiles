-- rustfmt / rust-analyzer from rustup live here. Ghostty/nvim launched from a
-- session that never sourced ~/.cargo/env would otherwise miss them.
local cargo_bin = vim.fn.expand('~/.cargo/bin')
if not string.find(':' .. vim.env.PATH .. ':', ':' .. cargo_bin .. ':', 1, true) then
  vim.env.PATH = cargo_bin .. ':' .. vim.env.PATH
end

local o = vim.o

-- Line numbers.
o.number = true
o.relativenumber = true

-- Indentation. Two spaces.
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

-- Files. undofile means undo history survives closing the buffer.
o.wrap = false
o.swapfile = false
o.backup = false
o.undofile = true
o.autoread = true

-- Searching.
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- UI.
o.scrolloff = 8
o.signcolumn = 'yes'
o.updatetime = 50
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.laststatus = 3 -- one global statusline, not one per split
o.termguicolors = true
o.guicursor = '' -- always a block cursor
o.colorcolumn = '80'
o.confirm = true

-- Border for ALL floating windows (hover, signature, diagnostics) in one place.
o.winborder = 'rounded'

vim.opt.isfname:append('@-@')

-- Native completion.
--   o = omnifunc, which on an LSP-attached buffer means the language server
--   . = current buffer, w = other windows, b = other loaded buffers
--   ^N = cap that source at N matches
-- Accept with <C-y>. <Tab>/<S-Tab> jump snippet placeholders (core defaults).
o.autocomplete = true
o.complete = 'o^10,.^5,w^3,b^3'
o.completeopt = 'menuone,popup,fuzzy,noselect'
