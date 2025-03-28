vim.diagnostic.config({
  virtual_text = true,
  underline = false,
  virtual_lines = false,
  signs = false,
  float = {
    source = "if_many",
  },
})

vim.api.nvim_create_user_command("DC", function(cmd_args)
  arg = cmd_args.fargs[1]

  local config
  if arg == "virtual_text" then
    config = { virtual_text = true, virtual_lines = false, underline = false }
  elseif arg == "virtual_lines" then
    config = { virtual_text = false, virtual_lines = true, underline = false }
  elseif arg == "underline" then
    config = { virtual_text = false, virtual_lines = false, underline = true }
  elseif arg == "off" then
    config = { virtual_text = false, virtual_lines = false, underline = false }
  else
    print("Invalid argument")
    return
  end

  vim.diagnostic.config(config)

  print("Diagnostics: " .. arg)
end, {
  nargs = 1,
  complete = function()
    return { "virtual_text", "virtual_lines", "underline" }
  end,
})

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

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
