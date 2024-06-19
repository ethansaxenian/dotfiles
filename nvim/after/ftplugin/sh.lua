local group = vim.api.nvim_create_augroup(".env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.env",
  group = group,
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.bufnr })
  end,
})
