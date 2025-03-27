vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

vim.g.virtual_text_on = true

vim.diagnostic.config({
  virtual_text = vim.g.virtual_text_on,
  underline = not vim.g.virtual_text_on,
  signs = false,
  float = {
    source = "if_many",
  },
})

vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
  vim.diagnostic.config({ virtual_text = not vim.g.virtual_text_on, underline = vim.g.virtual_text_on })
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
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts)
  end,
})

vim.lsp.enable({
  "basedpyright",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "golangci_lint_ls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "ruff",
  "tailwindcss",
  "templ",
  "ts_ls",
})
