---@type vim.lsp.Config
return {
  filetypes = { "html", "templ" },
  capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
}
