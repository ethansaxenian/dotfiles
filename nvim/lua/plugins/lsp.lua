vim.g.virtual_text_on = true

local lsp_group = vim.api.nvim_create_augroup("Lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
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
    vim.keymap.set("n", "<M-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
      vim.diagnostic.config({ virtual_text = not vim.g.virtual_text_on })
      vim.g.virtual_text_on = not vim.g.virtual_text_on
      print("Diagnostic Virtual Text: " .. tostring(vim.g.virtual_text_on))
    end, {})
  end,
})

local servers = {
  pyright = {
    capabilities = {
      textDocument = {
        publishDiagnostics = {
          tagSupport = {
            valueSet = { 2 },
          },
        },
      },
    },
    before_init = function(_, config)
      local function get_python_path(workspace)
        local path = require("lspconfig/util").path

        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
          return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        end

        -- Find and use virtualenv in workspace directory.
        for _, pattern in ipairs({ "*", ".*" }) do
          local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
          if match ~= "" then
            local venv = path.dirname(match)
            vim.env.VIRTUAL_ENV = venv
            vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
            return path.join(venv, "bin", "python")
          end
        end

        -- Fallback to system Python.
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
      end

      local python_path = get_python_path(config.root_dir)
      config.settings.python.pythonPath = python_path
    end,
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
      },
    },
  },

  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },

  html = {
    filetypes = { "html", "templ" },
  },

  tailwindcss = {
    filetypes = { "templ", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  },

  bashls = {},
  tsserver = {},
  ruff_lsp = {},
  jsonls = {},
  templ = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = vim.tbl_keys(servers)
        }
      },
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for server, server_opts in pairs(servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
        require("lspconfig")[server].setup(server_opts)
      end
    end,
  },
}