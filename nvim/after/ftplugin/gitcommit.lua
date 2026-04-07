vim.wo.wrap = true
vim.wo.spell = true

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.fn.cursor(1, 1)
  end,
  group = vim.api.nvim_create_augroup("gitconfig", { clear = true }),
  pattern = "*",
  desc = "move cursor to the first line",
})
