local augroup = vim.api.nvim_create_augroup('jassuwu', { clear = true })

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 40 })
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
