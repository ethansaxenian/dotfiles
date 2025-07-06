--- @param workspace string?
--- @return string
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  if workspace ~= nil then
    for _, pattern in ipairs({ "*", ".*" }) do
      local match = vim.fn.glob(vim.fs.joinpath(workspace, pattern, "pyvenv.cfg"))
      if match ~= "" then
        local venv = vim.fs.dirname(match)
        vim.env.VIRTUAL_ENV = venv
        vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
        return vim.fs.joinpath(venv, "bin", "python")
      end
    end
  end

  -- try uv python
  if vim.fn.executable("uv") then
    local uv_python = vim.system({ "uv", "python", "find" }):wait()
    if uv_python.stdout ~= "" then
      return vim.fn.trim(uv_python.stdout)
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

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
    local python_path = get_python_path(client.root_dir)
    client.settings = vim.tbl_deep_extend("force", client.settings, { python = { pythonPath = python_path } })
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
