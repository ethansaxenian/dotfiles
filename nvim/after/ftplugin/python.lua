vim.opt_local.foldmethod = "indent"
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.py",
--   callback = function(opts)
--     os.execute("black " .. opts.file)
--   end
-- })
