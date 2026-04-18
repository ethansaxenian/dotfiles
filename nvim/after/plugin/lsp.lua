vim.lsp.inlay_hint.enable(false)
vim.lsp.codelens.enable(false)

for _, capability in ipairs({ "codelens", "inline_completion", "inlay_hint", "semantic_tokens" }) do
  vim.api.nvim_create_user_command("Toggle" .. capability:gsub("^%l", string.upper):gsub("_", ""), function()
    local lsp_capability = vim.lsp[capability]
    local val = not lsp_capability.is_enabled()
    lsp_capability.enable(val)
    print(capability .. ": " .. tostring(val))
  end, { desc = "Toggle LSP " .. capability })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- Stop LSP servers that are disabled in project-local configs.
    if vim.g.project_disabled_lsp_servers then
      if vim.tbl_contains(vim.g.project_disabled_lsp_servers, client.name) then
        vim.lsp.enable(client.name, false)
        return
      end
    end

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

local servers = {
  "basedpyright",
  "bashls",
  "copilot",
  "docker_compose_language_service",
  "dockerls",
  "golangci_lint_ls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyrefly",
  "ruff",
  "tailwindcss",
  "templ",
  "tinymist",
  "tombi",
  "ts_ls",
  "ty",
}

vim.lsp.enable(servers)
