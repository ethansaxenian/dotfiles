if not pcall(require, "conform") then
  return
end

vim.g.format_on_save = true

require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    go = { "gofmt" }
  },
  format_on_save = function()
    if not vim.g.format_on_save then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
  formatters = {
    ruff_fix = {
      prepend_args = { "--select=I" }
    },
  }
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.format_on_save = not vim.g.format_on_save
  print("Format On Save: " .. tostring(vim.g.format_on_save))
end, {})
