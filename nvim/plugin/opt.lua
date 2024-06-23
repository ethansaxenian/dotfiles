vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wildmode = { "longest", "full" }
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.o", "*.img", "*.xlsx" }

vim.opt.wrap = false
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.breakindent = true

vim.opt.matchpairs:append("<:>")

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.timeoutlen = 500

vim.opt.foldenable = false

vim.opt.termguicolors = true

vim.opt.formatoptions:remove("o")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

local bufnr = "%2.2n"
local filename = "%.35F"
local flags = "%h%m%r%w"
local git_branch = "%{get(b:,'gitsigns_head','')}"
local git_status = "%{get(b:,'gitsigns_status','')}"
local filetype = "%{strlen(&ft)?&ft:'none'}"
local cursor_pos = "%(%l/%L,%c%V%)  %P"

vim.opt.statusline =
  string.format("%s %s %s %s %s %s %%= %s", bufnr, filename, flags, git_branch, git_status, filetype, cursor_pos)
