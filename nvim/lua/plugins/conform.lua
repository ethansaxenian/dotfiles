vim.g.format_on_save = true

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.format_on_save = not vim.g.format_on_save
  print("Format On Save: " .. tostring(vim.g.format_on_save))
end, {})

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      go = { "gofmt" },
      lua = { "stylua" },
    },
    formatters = {
      ruff_fix = {
        prepend_args = { "--select=I" },
      },
    },
    format_on_save = function()
      if not vim.g.format_on_save then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true, async = true }
    end,
  },
}
