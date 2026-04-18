---@module 'lspconfig'

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.basedpyright
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = "standard",
        diagnosticSeverityOverrides = {
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
          strictParameterNoneValue = true,
          deprecateTypingAliases = true,
          reportUnusedVariable = false,
          reportUnusedParameter = false,
          reportUnusedImport = false,
          reportUndefinedVariable = false,
          reportDeprecated = "warning",
          reportMatchNotExhaustive = "error",
          -- reportPrivateUsage = "warning",
          reportUnusedClass = "warning",
          reportUnusedFunction = "warning",
          reportUnreachable = "warning",
        },
      },
    },
  },
  on_attach = function(client)
    client.settings = vim.tbl_deep_extend("force", client.settings, {
      python = {
        pythonPath = require("util.python").get_python_path(client.root_dir),
      },
    })
  end,
  capabilities = {
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
    },
  },
}
