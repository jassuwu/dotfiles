-- ruff and basedpyright both attach to Python. Disable ruff's hover so basedpyright
-- owns the K / completion docs; ruff still lints and (via conform) formats.
return {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
