-- fix slow python loading time
vim.g.python3_host_prog = os.execute("which python3")

-- OPTIONS

vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 8

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.opt.wildmode = { "list", "longest", "full" }
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.o", "*.img", "*.xlsx" }

vim.opt.wrap = false
vim.opt.whichwrap:append "<,>,h,l"

vim.opt.matchpairs:append "<:>"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true

vim.o.timeoutlen = 500

vim.o.foldenable = false


-- STATUS LINE
vim.o.statusline = table.concat {
   "%2.2n ",
   "%.35F ",
   "%h%m%r%w ",
   "  %{strlen(&ft)?&ft:'none'} ",
   " %=",
   "%(%l/%L,%c%V%) %P",
}


-- AUTOCOMMANDS

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
   command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})

-- strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
   group = nvim_config,
   pattern = "*",
   command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
   group = nvim_config,
   callback = function()
      if vim.o.number and vim.fn.mode() ~= "i" then
         vim.o.relativenumber = true
      end
   end,
   pattern = '*',
})


vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
   group = nvim_config,
   callback = function()
      if vim.o.number then
         vim.o.relativenumber = false
      end
   end,
   pattern = '*',
})

function ToggleNumber()
   if vim.o.relativenumber then
      vim.o.number = true
      vim.o.relativenumber = false
   else
      vim.o.relativenumber = true
   end
end


-- MAPPINGS

vim.g.mapleader = " "

-- ctrl-c should behave the same as esc
vim.keymap.set("i", "<C-c>", "<ESC>")

-- source nvim nvim
vim.keymap.set("n", "<leader>so", ":so $MYVIMRC<CR>")

-- open file browser
vim.keymap.set("n", "<leader><CR>", vim.cmd.Ex)

-- don't use arrow keys
vim.keymap.set("", "<up>", "<nop>")
vim.keymap.set("", "<down>", "<nop>")
vim.keymap.set("", "<left>", "<nop>")
vim.keymap.set("", "<right>", "<nop>")

-- center cursor when searching or scrolling
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- move vertically by visual line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- move to beginning/end of line
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")

vim.keymap.set("n", "<leader>c", ":set cursorline! cursorcolumn!<CR>")
vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>")
vim.keymap.set("n", "<leader>t", ToggleNumber())

vim.keymap.set("n", "<leader>r", vim.cmd.registers)

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

vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-l>", "<C-w>l")
