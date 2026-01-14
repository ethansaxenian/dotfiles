local python = require("util.python")

--- @type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "pyrightconfig.json",
    "uv.lock",
  },
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
        pythonPath = python.get_python_path(client.root_dir),
      },
    })
    client.server_capabilities.semanticTokensProvider = nil
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
