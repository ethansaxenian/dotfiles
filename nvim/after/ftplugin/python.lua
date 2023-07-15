vim.opt_local.foldmethod = "indent"
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

vim.api.nvim_create_autocmd("BufWritePre", {
   callback = function()
      Format("black --stdin-filename % --quiet -")
      Format("ruff check --fix -")
   end
})
