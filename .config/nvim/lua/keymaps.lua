-- Only maps that are NOT already Neovim defaults.
--
-- Provided by core, deliberately absent here: grn rename, gra code action,
-- grr references, gri implementation, grt type definition, grx codelens,
-- gO document symbols, K hover, <C-s> signature help, [d/]d diagnostics,
-- <C-w>d diagnostic float, [q/]q quickfix, [b/]b buffers, gc/gcc comment,
-- an/in treesitter node selection, <Tab>/<S-Tab> snippet jump.

local map = vim.keymap.set

-- gd is NOT a native default (plain `gd` is "go to local declaration", and the LSP
-- route is <C-]> via tagfunc).
map('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: definition' })

-- File explorer: open the parent directory as an editable buffer.
map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

-- Pickers. <leader>f* is the family; <C-p> is the one alias, for reflex.
local fzf = require('fzf-lua')
map('n', '<C-p>', fzf.files, { desc = 'Find files' })
map('n', '<leader>ff', fzf.files, { desc = 'Find files' })
map('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })
map('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
map('n', '<leader>fh', fzf.helptags, { desc = 'Help tags' })
map('n', '<leader>fd', fzf.diagnostics_workspace, { desc = 'Diagnostics' })
map('n', '<leader>fs', fzf.lsp_document_symbols, { desc = 'Document symbols' })

-- Movement and editing.
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('n', 'J', 'mzJ`z', { desc = 'Join without moving cursor' })
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('x', '<leader>p', [["_dP]], { desc = 'Paste without clobbering register' })
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]])
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to black hole' })
map('i', '<C-c>', '<Esc>')
map('n', 'Q', '<nop>')
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = 'Replace word under cursor',
})

-- Location list. Quickfix has native [q/]q; the loclist has no equivalent.
map('n', '<leader>j', '<cmd>lprev<CR>zz')
map('n', '<leader>k', '<cmd>lnext<CR>zz')

-- Formatting. conform handles save; this is the manual escape hatch.
map({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ lsp_format = 'fallback', timeout_ms = 1000 })
end, { desc = 'Format buffer' })

-- Git: reading only. Staging and committing happen in a real terminal.
local gitsigns = require('gitsigns')

local function nav_hunk(direction)
  return function()
    -- ]c/[c are vim's own diff-mode motions; don't shadow them there.
    if vim.wo.diff then
      vim.cmd.normal({ direction == 'next' and ']c' or '[c', bang = true })
    else
      gitsigns.nav_hunk(direction)
    end
  end
end

map('n', ']c', nav_hunk('next'), { desc = 'Next hunk' })
map('n', '[c', nav_hunk('prev'), { desc = 'Previous hunk' })
map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
map('n', '<leader>hb', gitsigns.toggle_current_line_blame, { desc = 'Toggle line blame' })
