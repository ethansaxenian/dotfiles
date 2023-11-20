if not pcall(require, "lspconfig") then
  return
end

local virtual_text_on = true
local format_on_save = true

local lsp_group = vim.api.nvim_create_augroup('Lsp', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)

    vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
      vim.diagnostic.config({ virtual_text = not virtual_text_on })
      virtual_text_on = not virtual_text_on
      print("Diagnostic Virtual Text: " .. tostring(virtual_text_on))
    end, {})

    vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
      format_on_save = not format_on_save
      print("Format On Save: " .. tostring(format_on_save))
    end, {})

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          if format_on_save then
            vim.lsp.buf.format()
          end
        end,
        group = lsp_group,
        pattern = '*',
      })
    end
  end
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',
    'ruff_lsp',
    'jsonls',
    'lua_ls',
    'bashls',
    'efm',
    'gopls',
    'tsserver',
  }
})

local default_servers = {
  'ruff_lsp', 'jsonls', 'bashls', 'tsserver',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, server in ipairs(default_servers) do
  require('lspconfig')[server].setup({
    capabilities = capabilities,
  })
end

require('lspconfig').pyright.setup({
  -- ignore diagnostics that conflict with ruff_lsp
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
    },
  }),
  before_init = function(_, config)
    local function get_python_path(workspace)
      local path = require('lspconfig/util').path

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


require('lspconfig').lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' }
      },
    },
  }
})


require('lspconfig').gopls.setup({
  capabilities = capabilities,
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
  capabilities = capabilities,
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
