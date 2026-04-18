vim.g.mapleader = " "

require("vim._core.ui2").enable({ enable = true })

-- Disable python integration. Speeds up startup time.
vim.g.loaded_python3_provider = 0

vim.filetype.add({ extension = { templ = "templ" } })

vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 8

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.smartindent = true

vim.opt.wildmode = { "longest", "full" }
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.o", "*.img", "*.xlsx" }

vim.o.wrap = false
vim.opt.whichwrap:append("<,>,h,l")
vim.o.breakindent = true

vim.opt.matchpairs:append("<:>")

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.undofile = true
vim.o.swapfile = false

vim.o.foldenable = false
vim.o.foldlevel = 99

vim.opt.formatoptions:remove("t")

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.exrc = true

vim.keymap.set("i", "<C-c>", "<ESC>", { desc = "make ctrl-c behave like esc" })

vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

vim.keymap.set("n", "<leader><CR>", vim.cmd.Ex, { desc = "open file browser" })

-- center cursor while scrolling
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- move vertically by visual line
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>", { desc = "toggle wrap" })
vim.keymap.set("n", "<leader>n", "<Plug>ToggleNumber", { desc = "toggle number/relativenumber" })

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

-- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])

-- use J/K to move visual blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- indent visually selected blocks
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

local nvim_config = vim.api.nvim_create_augroup("nvim_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = nvim_config,
  pattern = "*",
  desc = "highlight yanked text",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = nvim_config,
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
  desc = "return to last edit position when opening files",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = nvim_config,
  pattern = "*",
  command = [[%s/\s\+$//e]],
  desc = "strip trailing whitespace on save",
})
