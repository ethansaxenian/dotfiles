if not pcall(require, "lsp-zero") then
  return
end


local lsp = require('lsp-zero').preset({})
local virtual_text_on = true

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ bufner = bufnr })
  lsp.buffer_autoformat()
  local opts = { buffer = bufnr }

  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, opts)

  vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
    vim.diagnostic.config({ virtual_text = not virtual_text_on })
    virtual_text_on = not virtual_text_on
    print("Diagnostic Virtual Text: " .. tostring(virtual_text_on))
  end, {})
end)

lsp.ensure_installed({
  'pyright',
  'ruff_lsp',
  'jsonls',
  'lua_ls',
  'bashls',
  'efm',
  'gopls',
  'tsserver',
})


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
require('lspconfig').pyright.setup({
  capabilities = capabilities,
  before_init = function(_, config)
    local function get_python_path(workspace)
      local util = require('lspconfig/util')
      local path = util.path

      -- Use activated virtualenv.
      if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
      end

      -- Find and use virtualenv in workspace directory.
      for _, pattern in ipairs({ '*', '.*' }) do
        local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
        if match ~= '' then
          return path.join(path.dirname(match), 'bin', 'python')
        end
      end

      -- Fallback to system Python.
      return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
    end

    local python_path = get_python_path(config.root_dir)
    config.settings.python.pythonPath = python_path
  end
})

require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- format python and typescript with efm
require('lspconfig').efm.setup({
  filetypes = { 'python', 'typescriptreact', 'typescript' },
  init_options = {
    documentFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true
  },
  settings = {
    rootMarkers = { ".git/", ".venv/", ".env", "pyproject.toml", "node_modules", "package.json" },
    languages = {
      python = {
        { formatCommand = "ruff check --fix --select=I -", formatStdin = true },
        { formatCommand = "ruff format -",                 formatStdin = true },
        { formatCommand = "black -",                       formatStdin = true },
      },
      typescript = {
        { formatCommand = "npx prettier --stdin-filepath ${INPUT}", formatStdin = true }
      },
      typescriptreact = {
        { formatCommand = "npx prettier --stdin-filepath ${INPUT}", formatStdin = true }
      },
    }
  }
})

lsp.setup()


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-J>'] = cmp_action.tab_complete(),
    ['<C-K>'] = cmp_action.select_prev_or_fallback(),

    ['<C-Space>'] = cmp.mapping.complete(),
  }
})
