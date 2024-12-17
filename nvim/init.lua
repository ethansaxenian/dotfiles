vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "plugins",
  change_detection = { notify = false },
})

-- fix slow python loading time
vim.g.python3_host_prog = os.execute("which python3")

vim.filetype.add({ extension = { templ = "templ" } })

vim.cmd.colorscheme("nightfox")
