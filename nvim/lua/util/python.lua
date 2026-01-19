local M = {}

---@param venv_path string
function M.activate_venv(venv_path)
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.PATH = vim.fs.joinpath(venv_path, "bin") .. ":" .. vim.env.PATH
end

---@param root_dir string
---@return string?, boolean
function M.find_venv(root_dir)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV, true
  end

  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(vim.fs.joinpath(root_dir, pattern, "pyvenv.cfg"))
    if match ~= "" then
      local venv = vim.fs.dirname(match)
      return venv, false
    end
  end

  return nil, false
end

function M.is_pep723_script()
  -- abort if uv is not installed
  if vim.fn.executable("uv") == 0 then
    return false
  end

  local buffer_contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if buffer_contents then
    for _, line in ipairs(buffer_contents) do
      local match = line:match("^# /// script$")
      if match then
        return true
      end
    end
  end

  return false
end

---@param script_path string
---@return string?
function M.create_venv_for_pep723_script(script_path)
  local temp_requirements = vim.fn.tempname()
  local temp_venv = vim.fn.tempname()

  -- Write requirements to a temporary file
  local export_res = vim.system({ "uv", "export", "--script", script_path }):wait()
  if export_res.code ~= 0 then
    vim.notify(
      "Failed to export requirements for PEP 723 script: " .. (export_res.stderr or "unknown error"),
      vim.log.levels.ERROR
    )
    return nil
  end
  vim.fn.writefile(vim.split(export_res.stdout, "\n"), temp_requirements)

  -- Create and activate virtual environment
  local venv_res = vim.system({ "uv", "venv", temp_venv }):wait()
  if venv_res.code ~= 0 then
    vim.notify(
      "Failed to create virtual environment for PEP 723 script: " .. (venv_res.stderr or "unknown error"),
      vim.log.levels.ERROR
    )
    return nil
  end

  M.activate_venv(temp_venv)

  -- Install requirements into the virtual environment
  local install_res = vim
    .system({
      "uv",
      "pip",
      "install",
      "--requirements",
      temp_requirements,
    })
    :wait()
  if install_res.code ~= 0 then
    vim.notify(
      "Failed to install requirements for PEP 723 script: " .. (install_res.stderr or "unknown error"),
      vim.log.levels.ERROR
    )
    return nil
  end

  vim.fn.delete(temp_requirements)

  return temp_venv
end

---@param workspace string?
---@return string
function M.get_python_path(workspace)
  -- Use PEP 723 virtual environment via uv if defined
  if M.is_pep723_script() then
    local venv = M.create_venv_for_pep723_script(vim.api.nvim_buf_get_name(0))
    if venv ~= nil then
      return vim.fs.joinpath(venv, "bin", "python")
    end
  end

  -- Find and use virtualenv in workspace directory.
  if workspace ~= nil then
    local venv, active = M.find_venv(workspace)
    if venv ~= nil then
      if not active then
        M.activate_venv(venv)
      end

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
