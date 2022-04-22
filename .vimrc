" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

	Plug 'sheerun/vim-polyglot'
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'flazz/vim-colorschemes'

call plug#end()

" MISC {{{
" Sets how many lines of history VIM has to remember
set history=1000

" set undo history size
set undolevels=1000

" automatically re-read files if unmodified inside Vim
set autoread

" Enable file type detection
filetype plugin on
filetype indent on

" enable mouse in all modes
set mouse=a

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" }}}
" UI {{{
" Start scrolling four lines before the horizontal window border
set scrolloff=4

" Turn on the Wild menu
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.o,*.img,*.xlsx

" Show the cursor position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" wrap lines with h and l
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Enable line numbers
set number

" show command in bottom bar
set showcmd

set foldmethod=marker
" }}}
" SEARCHING {{{
" Ignore case when searching
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Highlight search results
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch
" }}}
" COLORS {{{
set t_Co=256
set termguicolors

let g:python_highlight_operators = 0

colorscheme mycolors
autocmd BufRead,BufNewFile *.asm set filetype=asm

set background=dark

" Enable syntax highlighting
syntax enable
" }}}
" BACKUPS {{{
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb

" set directory for swap files
set directory=~/.vim/swp//

" turn persistent undo on
" means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim/undo//
    set undofile
catch
endtry
" }}}
" TABS/SPACES {{{
" Be smart when using tabs ;)
set softtabstop=4

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" insert spaces whenever tab is pressed
set expandtab

set ai "Auto indent
set si "Smart indent

" change tab size based on file type
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
" }}}
" STATUS LINE {{{
function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" set the status line
set statusline=%#StatusLine2#				  " set highlighting
set statusline+=%-2.2n\                       " buffer number
set statusline+=%#StatusLine1#                " set highlighting
set statusline+=%f\                           " file name
set statusline+=%#StatusLine2#                " set highlighting
set statusline+=%h%m%r%w\                     " flags
set statusline+=%{strlen(&ft)?&ft:'none'}\ \  " file type
set statusline+=%{SyntaxItem()}\              " syntax highlight group under cursor
set statusline+=%=\                           " indent to the right
set statusline+=%(%l,%c%V%)\ \ %P			  " cursor position/offset

set laststatus=2
" }}}
" MAPPINGS {{{
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Disable highlight when <leader><cr> is pressed
map <leader><cr> :noh<cr>

" Type jj to exit insert mode quickly
inoremap jj <esc>

" Press ,, to jump back to the last cursor position.
nnoremap <leader><leader> ``

" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

" $/0 doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" quick reload
noremap <leader>r :source ~/.vimrc<cr>

" quick saving and quitting
noremap <leader>q :q!<cr>
noremap <leader>w :wq<cr>
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" Don't use arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" d/c don't copy text: _ is the blackhole buffer
noremap d "_d
noremap dd "_dd
noremap c "_c
noremap cc "_cc

" use H and L with c and d
nnoremap cH "_c^
nnoremap cL "_c$
nnoremap dH "_d^
nnoremap dL "_d$

" indent visually selected blocks
vnoremap < <gv
vnoremap > >gv

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" space open/closes folds
nnoremap <space> za

" Useful mappings for managing tabs
map <leader>tt :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" }}}
" FUNCTIONS {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
" }}}
