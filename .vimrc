" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

  Plug 'bfrg/vim-cpp-modern'
  Plug 'vim-python/python-syntax'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'leafgarland/typescript-vim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'flazz/vim-colorschemes'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf'
  Plug 'fatih/vim-go'

call plug#end()

" MISC {{{
" remove all autocommands
autocmd!

" Sets how many lines of history VIM has to remember
set history=1000

" set undo history size
set undolevels=1000

" automatically re-read files if unmodified inside Vim
set autoread

" Enable file type detection
filetype plugin indent on

" enable mouse in all modes
set mouse=a

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

" match < and >
set matchpairs+=<:>

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

set splitbelow splitright
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
set termguicolors

colorscheme mycolors

set background=dark

" Enable syntax highlighting
syntax enable
" }}}
" BACKUPS {{{
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup

" swap file directory
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

" 1 tab == 2 spaces by default
set shiftwidth=2
set tabstop=2
set softtabstop=2

" insert spaces whenever tab is pressed
set expandtab

set autoindent " Auto indent
set smartindent " Smart indent
" }}}
" STATUS LINE {{{
function! SyntaxItem()
  return synIDattr(synID(line("."), col("."), 1), "name")
endfunction

function! GitStatusA()
  let [a,_,_] = GitGutterGetHunkSummary()
  return printf('+%d', a)
endfunction

function! GitStatusM()
  let [_,m,_] = GitGutterGetHunkSummary()
  return printf('~%d', m)
endfunction

function! GitStatusR()
  let [_,_,r] = GitGutterGetHunkSummary()
  return printf('-%d', r)
endfunction

" set the status line
set statusline=%#StatusLinePurple#			     " set highlighting
set statusline+=%2.2n\                       " buffer number
set statusline+=%#StatusLineRed#             " set highlighting
set statusline+=%.35F\                       " file name
set statusline+=%#StatusLinePurple#          " set highlighting
set statusline+=%h%m%r%w\                    " flags
set statusline+=%{FugitiveStatusline()}\     " git branch
set statusline+=%#GitAddedSL#
set statusline+=%{GitStatusA()}\             " number of lines added
set statusline+=%#GitModifiedSL#
set statusline+=%{GitStatusM()}\             " number of lines modified
set statusline+=%#GitRemovedSL#
set statusline+=%{GitStatusR()}\ \           " number of lines removed
set statusline+=%#StatusLinePurple#          " set highlighting
set statusline+=%{strlen(&ft)?&ft:'none'}\ \ " file type
set statusline+=%{SyntaxItem()}\             " syntax highlight group under cursor
set statusline+=%=\                          " indent to the right
set statusline+=%#StatusLinePurple#          " set highlighting
set statusline+=%(%l/%L,%c%V%)\ \ %P\        " cursor position/offset

set laststatus=2
" }}}
" MAPPINGS {{{
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Disable highlight when <leader><cr> is pressed
map <leader><cr> :noh<cr>

" Type jk to exit insert mode quickly
inoremap jk <esc>

" Press ,, to jump back to the last cursor position.
nnoremap <leader><leader> ``

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

" quick reload
noremap <leader>r :source $HOME/.vimrc<cr> :e<cr> :nohl<cr>

" quick saving and quitting
noremap <leader>q :q!<cr>
noremap <leader>w :call StripExtraWhiteSpace()<cr>:wq<cr>
nnoremap <leader>s :call StripExtraWhiteSpace()<cr>:w<cr>
inoremap <leader>s <esc>:call StripExtraWhiteSpace()<cr>:w<cr>

" Don't use arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" indent visually selected blocks
vnoremap < <gv
vnoremap > >gv

" opening splits
noremap <leader>sv :Se!<cr>:FZF<cr>
noremap <leader>sh :Se<cr>:FZF<cr>

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
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
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

" Trim extra whitespace
function! StripExtraWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
" }}}
" FILETYPES {{{
" Python
let g:python_highlight_operators = 0
let g:python_highlight_all = 1

augroup Python
  autocmd!
  autocmd BufRead,BufNewFile *.py setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile *.py setlocal tabstop=2
  autocmd BufRead,BufNewFile *.py setlocal shiftwidth=2
  autocmd BufRead,BufNewFile *.py setlocal softtabstop=2
  autocmd BufRead,BufNewFile *.py setlocal noexpandtab
augroup END

" Golang

let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 1

augroup Go
  autocmd!
  autocmd BufRead,BufNewFile *.go setlocal foldmethod=indent
  autocmd BufRead,BufNewFile *.go setlocal tabstop=2
  autocmd BufRead,BufNewFile *.go setlocal shiftwidth=2
  autocmd BufRead,BufNewFile *.go setlocal softtabstop=2
  autocmd BufRead,BufNewFile *.go setlocal noexpandtab
augroup END


" JavaScript/TypeScript

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" turn off yats.vim (enabled by default) which adds too many typescript syntax items
let g:yats_host_keyword = 0
let g:typescript_ignore_browserwords = 0

augroup JavaScript
  autocmd!
  autocmd BufRead,BufNewFile *.{js,jsx,ts,tsx} setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile *.{js,jsx,ts,tsx} setlocal tabstop=2
  autocmd BufRead,BufNewFile *.{js,jsx,ts,tsx} setlocal shiftwidth=2
  autocmd BufRead,BufNewFile *.{js,jsx,ts,tsx} setlocal softtabstop=2
augroup END

" Misc
augroup Misc
  autocmd!
  autocmd BufRead,BufNewFile *.{html,css} setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile *.{html,css} setlocal tabstop=2
  autocmd BufRead,BufNewFile *.{html,css} setlocal shiftwidth=2
  autocmd BufRead,BufNewFile *.{html,css} setlocal softtabstop=2

  autocmd FileType make setlocal noexpandtab

  autocmd BufRead,BufNewFile *.asm set filetype=asm

  autocmd BufRead,BufNewFile *.{py,js,jsx,ts,tsx,html,css,go} normal zR
augroup END
" }}}
" PLUGINS {{{

" NERDTree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

nmap <leader>n :NERDTreeFocus<CR>

let NERDTreeIgnore = ['\.git$[[dir]]', 'node_modules[[dir]]', '\.DS_Store', '\.idea[[dir]]', '__pycache__[[dir]]', 'build[[dir]]', 'venv$[[dir]]', '\.o$', '\.so$', '\.dSYM$']
let NERDTreeWinPos = "left"
let NERDTreeWinSize = 50

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ctrl-/ toggles comments
map <C-_> <plug>NERDCommenterToggle

" GitGutter
" show if fold contains changed text
set foldtext=gitgutter#fold#foldtext()

" FZF
map <leader>f :FZF<CR>
" }}}
