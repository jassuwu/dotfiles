return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim'},
    config = function ()
      require("telescope").setup({})

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end,
  },
}
