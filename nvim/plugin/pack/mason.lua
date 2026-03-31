---@module 'mason'

vim.pack.add({ "https://github.com/williamboman/mason.nvim" })

local tools = {
  { "lua-language-server", version = "3.16.4" },
  "basedpyright",
  "bash-language-server",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "eslint-lsp",
  "golangci-lint",
  "golangci-lint-langserver",
  "gopls",
  "html-lsp",
  "json-lsp",
  "prettier",
  "ruff",
  "shellcheck",
  "stylua",
  "tailwindcss-language-server",
  "templ",
  "tinymist",
  "tombi",
  "tree-sitter-cli",
  "ty",
  "typescript-language-server",
  "typstyle",
}

require('mason').setup()

local mr = require("mason-registry")
for _, tool in ipairs(tools) do
  local name = tool[1] or tool
  local version = tool.version
  local p = mr.get_package(name)

  if not p:is_installed() or (version ~= nil and p:get_installed_version() ~= version) then
    p:install({ version = version })
  end
end
