local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- Default options

require("lazy").setup({
  -- {
  "EdenEast/nightfox.nvim",
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  "junegunn/fzf",
  "junegunn/fzf.vim",

  "romainl/vim-cool",
  'lewis6991/gitsigns.nvim',
  "tpope/vim-commentary",
  "tpope/vim-surround",

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "vim", "vimdoc", "go" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
})



vim.cmd.colorscheme "nightfox"

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

vim.opt.wildmode = { "longest", "full" }
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.o", "*.img", "*.xlsx" }

vim.opt.wrap = false
vim.opt.whichwrap:append "<,>,h,l"
vim.opt.breakindent = true

vim.opt.matchpairs:append "<:>"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.swapfile = false

vim.o.timeoutlen = 500

vim.o.foldenable = false


-- STATUS LINE

vim.cmd([[
set statusline=%2.2n\                             " buffer number
set statusline+=%.35F\                            " file name
set statusline+=%h%m%r%w\                         " flags
set statusline+=%{get(b:,'gitsigns_head','')}\    " git branch
set statusline+=%{get(b:,'gitsigns_status','')}\  " git changes
set statusline+=%{strlen(&ft)?&ft:'none'}\ \      " file type
set statusline+=%=\                               " indent to the right
set statusline+=%(%l/%L,%c%V%)\ \ %P\             " cursor position/offset
]])

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

-- disable nightfox italics :/
vim.api.nvim_create_autocmd("BufEnter", {
  group = nvim_config,
  pattern = "*",
  callback = function()
    vim.cmd("highlight @tag.attribute gui=NONE cterm=NONE")
  end
})

-- automatically enter insert mode in Terminal buffer
vim.api.nvim_create_autocmd("TermOpen", {
  group = nvim_config,
  callback = function()
    vim.cmd("startinsert!")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

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
vim.keymap.set("n", "<leader>t", "<Plug>ToggleNumber")

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

-- Terminal Mode

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Plugins

vim.g.fzf_layout = { window = { width = 1, height = 1 } }
vim.g.fzf_preview_window = { "right,50%", "ctrl-p" }

vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)
vim.keymap.set("n", "<leader>h", ":History:<CR>")
vim.keymap.set("n", "<leader>l", vim.cmd.Lines)
vim.keymap.set("n", "<leader>m", vim.cmd.Marks)
vim.keymap.set("n", "<leader>f", "<Plug>FzfFiles")
vim.keymap.set("n", "<leader>F", "<Plug>FzfAllFiles")
vim.keymap.set("n", "<leader>rg", vim.cmd.RG)
vim.keymap.set("n", "<leader>j", vim.cmd.Jumps)
