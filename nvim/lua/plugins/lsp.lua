local servers = {
  basedpyright = {
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
      local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
          return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
        end

        -- Find and use virtualenv in workspace directory.
        for _, pattern in ipairs({ "*", ".*" }) do
          local match = vim.fn.glob(vim.fs.joinpath(workspace, pattern, "pyvenv.cfg"))
          if match ~= "" then
            local venv = vim.fs.dirname(match)
            vim.env.VIRTUAL_ENV = venv
            vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
            return vim.fs.joinpath(venv, "bin", "python")
          end
        end

        -- try uv python
        if vim.fn.executable("uv") then
          local uv_python = vim.system({ "uv", "python", "find" }):wait()
          if uv_python.stdout ~= "" then
            return string.gsub(uv_python.stdout, "\n", "")
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
        -- configuration = "",
        configurationPreference = "filesystemFirst",
        showSyntaxErrors = false,
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

  lua_ls = {},
  bashls = {},
  ts_ls = {},
  jsonls = {},
  templ = {},
  docker_compose_language_service = {},
  dockerls = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "saghen/blink.cmp" },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

      for server, server_opts in pairs(servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
        require("lspconfig")[server].setup(server_opts)
      end
    end,

    init = function()
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
    end,
  },
}
