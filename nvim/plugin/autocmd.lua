local nvim_config = vim.api.nvim_create_augroup("nvim_config", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = nvim_config,
  pattern = "*",
})

-- return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = nvim_config,
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})

-- strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = nvim_config,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- automatically enter insert mode in Terminal buffer
vim.api.nvim_create_autocmd("TermOpen", {
  group = nvim_config,
  callback = function()
    vim.cmd("startinsert!")
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})
