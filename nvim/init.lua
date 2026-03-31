vim.g.mapleader = " "

-- fix slow python loading time
vim.g.python3_host_prog = require("util.python").get_python_path()

vim.filetype.add({ extension = { templ = "templ" } })
