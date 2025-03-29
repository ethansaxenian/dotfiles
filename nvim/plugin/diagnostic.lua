vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  underline = false,
  signs = false,
  float = {
    source = "if_many",
  },
})

--- @param field 'virtual_text'|'virtual_lines'
--- @return boolean|table
local function get_diagnostic_opt(field)
  local config = vim.diagnostic.config()
  return config and config[field] or false
end

local function open_float()
  vim.diagnostic.config({ virtual_lines = { current_line = true } })
end

local function close_float()
  vim.diagnostic.config({ virtual_lines = false })
end

vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist)
vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>e", function()
  if get_diagnostic_opt("virtual_lines") then
    close_float()
  else
    open_float()
  end

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("diagnostics", { clear = true }),
    once = true,
    callback = close_float,
  })
end)

vim.api.nvim_create_user_command("ToggleDiagnosticVirtualText", function()
  local virtual_text = get_diagnostic_opt("virtual_text")
  vim.diagnostic.config({
    virtual_text = not virtual_text,
    underline = virtual_text,
  })
  print("Diagnostic Virtual Text: " .. tostring(not virtual_text))
end, {})
