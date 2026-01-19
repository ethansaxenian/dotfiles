vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.o.number and vim.fn.mode() ~= "i" then
      vim.o.relativenumber = true
    end
  end,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.o.number then
      vim.o.relativenumber = false
    end
  end,
  pattern = "*",
})

function _ToggleNumber()
  if vim.o.relativenumber then
    vim.o.number = true
    vim.o.relativenumber = false
  else
    vim.o.relativenumber = true
  end
end

vim.keymap.set("n", "<Plug>ToggleNumber", _ToggleNumber, { desc = "<Plug>ToggleNumber" })
