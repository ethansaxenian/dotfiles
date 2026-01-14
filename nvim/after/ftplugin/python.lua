local python = require("util.python")

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

if vim.env.VIRTUAL_ENV == nil then
  local root_dir = vim.fs.root(0, {
    ".git",
    "pyproject.toml",
    "requirements.txt",
    "uv.lock",
  })

  if root_dir ~= nil then
    python.activate_venv(root_dir)
  end
end
