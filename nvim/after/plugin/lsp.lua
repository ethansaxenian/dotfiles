---@module 'lspconfig'

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "vim.lsp.buf.definition" })

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp, event.buf) then
      vim.keymap.set(
        { "n", "i" },
        "<C-k>",
        vim.lsp.buf.signature_help,
        { buffer = event.buf, desc = "vim.lsp.buf.signature_help" }
      )
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = event.buf })

      vim.keymap.set("i", "<Tab>", function()
        if not vim.lsp.inline_completion.get() then
          return "<Tab>"
        end
      end, { desc = "accept inline completion", buffer = event.buf, expr = true })

      vim.keymap.set(
        "i",
        "<C-G>",
        vim.lsp.inline_completion.select,
        { desc = "switch inline completion", buffer = event.buf }
      )
    end
  end,
})

---@type table<string, vim.lsp.Config>
local servers = {
  basedpyright = {
    ---@type lspconfig.settings.basedpyright
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
      client.settings = vim.tbl_deep_extend("force", client.settings, {
        python = {
          pythonPath = require("util.python").get_python_path(client.root_dir),
        },
      })
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

  bashls = {},

  copilot = { settings = { telemetry = { telemetryLevel = "off" } } },

  docker_compose_language_service = {},
  dockerls = {},
  golangci_lint_ls = {},

  gopls = {
    settings = {
      gopls = {
        analyses = {
          shadow = true,
          unusedvariable = true,
          useany = true,
        },
        staticcheck = true,
        vulncheck = "Imports",
      },
    },
  },

  html = {
    filetypes = { "html", "templ" },
    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
  },

  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
  },

  lua_ls = {},

  -- pyrefly = {
  --   on_attach = function(client)
  --     client.server_capabilities.semanticTokensProvider = nil
  --   end,
  -- },

  ruff = {
    settings = {
      init_options = {
        settings = {
          configurationPreference = "filesystemFirst",
          showSyntaxErrors = true,
        },
      },
    },
  },

  tailwindcss = {
    init_options = { userLanguages = { templ = "html" } },
  },

  templ = {},
  tinymist = {},
  tombi = {},
  ts_ls = {},
  ty = {},
}

vim.lsp.config("*", {
  root_markers = { ".git" },
})

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
