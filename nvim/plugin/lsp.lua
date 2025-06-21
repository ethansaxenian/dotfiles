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
  end,
})

vim.lsp.config("*", {
  root_markers = { ".git" },
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
  "tinymist",
  "ts_ls",
  "ty",
})
