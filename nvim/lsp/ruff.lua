--- @type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", "uv.lock" },
  settings = {
    init_options = {
      settings = {
        configurationPreference = "filesystemFirst",
        showSyntaxErrors = true,
      },
    },
  },
}
