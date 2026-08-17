local augroup = vim.api.nvim_create_augroup('jassuwu', { clear = true })

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 40 })
  end,
})

-- Strip trailing whitespace on save without moving the cursor or clobbering `/`.
-- Skip non-modifiable buffers (checkhealth, help, oil preview, etc.).
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Reopen a file at the position you left it.
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
