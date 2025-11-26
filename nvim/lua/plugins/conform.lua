--- @module 'lazy'
--- @module 'conform'

--- @type LazySpec
return {
  "stevearc/conform.nvim",

  --- @type conform.setupOpts
  opts = {
    formatters_by_ft = {
      go = { "gofmt" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      templ = { "templ" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      typst = { "typstyle" },
    },
    format_on_save = function()
      if not vim.g.format_on_save then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback", quiet = true }
    end,
  },
  init = function()
    vim.g.format_on_save = true

    vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
      vim.g.format_on_save = not vim.g.format_on_save
      print("Format On Save: " .. tostring(vim.g.format_on_save))
    end, {})
  end,
}
