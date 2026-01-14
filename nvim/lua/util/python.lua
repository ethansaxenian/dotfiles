local M = {}

--- @param root_dir string
--- @return string?
function M.activate_venv(root_dir)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV
  end

  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(vim.fs.joinpath(root_dir, pattern, "pyvenv.cfg"))
    if match ~= "" then
      local venv = vim.fs.dirname(match)
      vim.env.VIRTUAL_ENV = venv
      vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
      return venv
    end
  end

  return nil
end

--- @param workspace string?
--- @return string
function M.get_python_path(workspace)
  -- Find and use virtualenv in workspace directory.
  if workspace ~= nil then
    local venv = M.activate_venv(workspace)
    if venv ~= nil then
      return vim.fs.joinpath(venv, "bin", "python")
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

return M
