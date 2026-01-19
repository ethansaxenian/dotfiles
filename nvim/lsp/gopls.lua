---@type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { ".git", "go.work", "go.mod", "go.sum" },
  settings = {
    gopls = {
      analyses = {
        shadow = true,
        unusedvariable = true,
        useany = true,
      },
      staticcheck = true,
      vulncheck = "Imports",
    },
  },
}
