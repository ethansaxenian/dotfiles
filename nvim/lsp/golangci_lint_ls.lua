--- @type vim.lsp.Config
return {
  cmd = { "golangci-lint-langserver" },
  filetypes = { "go", "gomod" },
  root_markers = {
    ".git",
    ".golangci.yml",
    ".golangci.yaml",
    ".golangci.toml",
    ".golangci.json",
    "go.work",
    "go.mod",
  },
  init_options = {
    command = { "golangci-lint", "run", "--output.json.path", "stdout" },
  },
}
