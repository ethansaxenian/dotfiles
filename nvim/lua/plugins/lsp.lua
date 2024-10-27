vim.g.virtual_text_on = true

vim.diagnostic.config({
  underline = false,
  signs = false,
  float = {
    source = "if_many",
  },
})

vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
  vim.diagnostic.config({ virtual_text = not vim.g.virtual_text_on })
  vim.g.virtual_text_on = not vim.g.virtual_text_on
  print("Diagnostic Virtual Text: " .. tostring(vim.g.virtual_text_on))
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts)
  end,
})

local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = "standard",
          diagnosticSeverityOverrides = {
            reportUnusedVariable = false,
            reportUndefinedVariable = false,
            strictListInference = true,
            strictDictionaryInference = true,
            strictSetInference = true,
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
  },

  ruff = {
    init_options = {
      settings = {
        showSyntaxErrors = false,
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
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
          shadow = true,
          unusedvariable = true,
          useany = true,
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
  ts_ls = {},
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
        config = true,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = vim.tbl_keys(servers),
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      for server, server_opts in pairs(servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
        require("lspconfig")[server].setup(server_opts)
      end
    end,
  },
}
