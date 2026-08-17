-- Makes lua_ls aware of the Neovim runtime, so editing this config gets real
-- completion and no false `undefined global vim` diagnostics. The zero-plugin
-- alternative to lazydev.nvim.
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('lua', true),
      },
      diagnostics = { globals = { 'vim' } },
      telemetry = { enable = false },
    },
  },
}
