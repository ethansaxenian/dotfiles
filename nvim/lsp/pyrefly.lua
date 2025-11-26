--- @type vim.lsp.Config
return {
  cmd = { "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = { "pyrefly.toml", "pyproject.toml", ".git", "uv.lock" },
  on_attach = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
