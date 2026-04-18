---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = {
        shadow = true,
        unusedvariable = true,
        useany = true,
      },
      staticcheck = true,
      vulncheck = "Imports",
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
