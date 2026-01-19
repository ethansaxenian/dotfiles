vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "vim.lsp.buf.definition" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "vim.lsp.buf.type_definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "vim.lsp.buf.hover" })
    vim.keymap.set(
      { "n", "i" },
      "<C-k>",
      vim.lsp.buf.signature_help,
      { buffer = event.buf, desc = "vim.lsp.buf.signature_help" }
    )
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
  "tombi",
  "ts_ls",
  -- "ty",
})
