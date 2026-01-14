local python = require("util.python")

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
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = "~/projects",
    fallback = true,
    patterns = { "blink-cmp-" },
  },
})

-- fix slow python loading time
vim.g.python3_host_prog = python.get_python_path()

vim.filetype.add({ extension = { templ = "templ" } })

vim.cmd.colorscheme("nightfox")
