vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*compose*",
  group = vim.api.nvim_create_augroup("yaml", { clear = true }),
  callback = function(_)
    vim.opt_local.filetype = "yaml.docker-compose"
  end,
})
