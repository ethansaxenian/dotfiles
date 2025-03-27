-- ctrl-c should behave the same as esc
vim.keymap.set("i", "<C-c>", "<ESC>")

vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- open file browser
vim.keymap.set("n", "<leader><CR>", vim.cmd.Ex)

-- center cursor when searching or scrolling
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- move vertically by visual line
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- move to beginning/end of line
vim.keymap.set({ "n", "v" }, "H", "^")

vim.keymap.set({ "n", "v" }, "L", "$")

vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>")
vim.keymap.set("n", "<leader>n", "<Plug>ToggleNumber")

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

-- Terminal Mode

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
