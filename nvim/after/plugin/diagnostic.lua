vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  underline = false,
  signs = false,
  float = {
    source = true,
  },
})

vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "vim.diagnostic.setloclist" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "vim.diagnostic.setqflist" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })

local valid_fields = { "virtual_text", "virtual_lines", "underline", "signs" }

vim.api.nvim_create_user_command("DiagnosticDisplayMode", function(opts)
  local arg = opts.fargs[1]
  local next_config = vim.diagnostic.config()

  for _, field in ipairs(valid_fields) do
    next_config[field] = arg == field
  end

  vim.diagnostic.config(next_config)
  print(arg)
end, {
  nargs = 1,
  complete = function()
    return vim.list_extend({ "none" }, valid_fields)
  end,
  desc = "Toggle diagnostic display mode",
})
