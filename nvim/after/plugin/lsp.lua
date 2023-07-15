local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

lsp.ensure_installed({
  'pyright',
  'jsonls',
  'lua_ls',
  'bashls',
})


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
