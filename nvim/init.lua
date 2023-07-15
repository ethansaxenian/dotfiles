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
  {
    "EdenEast/nightfox.nvim",
    opts = {
      palettes = {
        nightfox = {
          -- swap background and statusline colors
          bg1 = "#131a24",
          bg0 = "#192330",
        },
      },
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = { disable_italics = true }
  },

  "junegunn/fzf",
  "junegunn/fzf.vim",

  "romainl/vim-cool",
  "airblade/vim-gitgutter",
  "scrooloose/nerdcommenter",
  "tpope/vim-surround",

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {                            -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
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
})



vim.cmd.colorscheme "nightfox"

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
function GitStatus()
  local a, m, r = unpack(vim.fn["GitGutterGetHunkSummary"]())
  return string.format("+%d ~%d -%d", a, m, r)
end

vim.o.statusline = table.concat {
  "%2.2n ",
  "%.35F ",
  "%h%m%r%w ",
  GitStatus(),
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


-- MAPPINGS

vim.g.mapleader = " "

-- ctrl-c should behave the same as esc
vim.keymap.set("i", "<C-c>", "<ESC>")

-- open file browser
vim.keymap.set("n", "<leader><CR>", vim.cmd.Ex)

-- don't use arrow keys
vim.keymap.set("", "<up>", "<nop>")
vim.keymap.set("", "<down>", "<nop>")
vim.keymap.set("", "<left>", "<nop>")
vim.keymap.set("", "<right>", "<nop>")

-- center cursor when searching
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

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

-- Pluging

vim.g.fzf_layout = { window = { width = 1, height = 0.5, relative = true, yoffset = 1.0 } }
vim.g.fzf_preview_window = { "right,50%", "ctrl-p" }

vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)
vim.keymap.set("n", "<leader>h", vim.cmd.History)
vim.keymap.set("n", "<leader>l", vim.cmd.Lines)
vim.keymap.set("n", "<leader>m", vim.cmd.Marks)
vim.keymap.set("n", "<leader>f", "<Plug>FzfFiles")
vim.keymap.set("n", "<leader>F", "<Plug>FzfAllFiles")
vim.keymap.set("n", "<leader>rg", vim.cmd.RG)

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = "left"

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1

-- ctrl-/ toggles comments
vim.keymap.set("", "<C-/>", "<Plug>NERDCommenterToggle")

-- don't define any gitgutter mappings by default
vim.g.gitgutter_map_keys = 0

-- show if fold contains changed text
vim.o.foldtext = vim.fn["gitgutter#fold#foldtext"]()
