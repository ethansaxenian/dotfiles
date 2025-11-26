vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
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
  -- "pyrefly",
  "ruff",
  "tailwindcss",
  "templ",
  "tinymist",
  "ts_ls",
  -- "ty",
})
