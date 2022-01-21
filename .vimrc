" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

	Plug 'sheerun/vim-polyglot'
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'flazz/vim-colorschemes'

call plug#end()

" Sets how many lines of history VIM has to remember
set history=1000

" automatically re-read files if unmodified inside Vim
set autoread

" Enable file type detection
filetype plugin on
filetype indent on

" Automatic commands
if has("autocmd")
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" enable mouse in all modes
set mouse=a

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


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

" Ignore case when searching
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Highlight search results
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch

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

set t_Co=256
set termguicolors

let g:cpp_function_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:python_highlight_all = 1

colorscheme normal 
autocmd Filetype c colorscheme c

set background=dark

" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set ai "Auto indent
set si "Smart indent

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
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

"  Load Once: {{{1
if exists("g:loaded_hilinks") || &cp
  finish
endif
let g:loaded_hilinks= "v4j"
if v:version < 700
 echohl WarningMsg
 echo "***warning*** this version of hilinks needs vim 7.0"
 echohl Normal
 finish
endif
let s:keepcpo= &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Initialization: {{{1
let s:HLTmode       = 0

" ---------------------------------------------------------------------
" Public Interface: {{{1
if !hasmapto('<Plug>HiLinkTrace')
  map <s-F10>  <Leader>hlt
  map <unique> <Leader>hlt <Plug>HiLinkTrace
endif
map <script> <Plug>HiLinkTrace	:call <SID>HiLinkTrace(0)<CR>
com! -bang	HLT					call s:HiLinkTrace(<bang>0)
com!		HLTm				call s:HiLinkTrace(1)

" ---------------------------------------------------------------------
"  Options: {{{1
if !exists("g:hilinks_fmtwidth")
 let g:hilinks_fmtwidth= 35
endif

" ---------------------------------------------------------------------
" HiLinkTrace: this function traces the highlighting group names {{{1
"             from transparent/top level through to the bottom
fun! <SID>HiLinkTrace(always)
"  call Dfunc("HiLinkTrace(always=".a:always.")")

  " save register a
  let keep_rega= @a

  " get highlighting linkages into register "a"
  redir @a
   silent! hi
  redir END
"  call Decho("reg-A now has :hi output")

  " initialize with top-level highlighting
  let firstlink = synIDattr(synID(line("."),col("."),1),"name")
  let lastlink  = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
  let translink = synIDattr(synID(line("."),col("."),0),"name")
"  call Decho("firstlink<".firstlink."> lastlink<".lastlink."> translink<".translink.">")

  " if transparent link isn't the same as the top highlighting link,
  " then indicate it with a leading "T:"
  if firstlink != translink
   let hilink= "T:".translink."->".firstlink
"   call Decho("firstlink!=translink<".hilink.">")
  else
   let hilink= firstlink
"   call Decho("firstlink==translink<".hilink.">")
  endif

  " trace through the linkages
  if firstlink != lastlink
   let no_overflow= 0
   let curlink    = firstlink
"   call Decho("loop#".no_overflow.": hilink<".hilink.">")
   while curlink != lastlink && no_overflow < 10
   	let no_overflow = no_overflow + 1
   	let nxtlink     = substitute(@a,'^.*\<'.curlink.'\s\+xxx links to \(\a\+\).*$','\1','')
	if nxtlink =~ '\<start=\|\<cterm[fb]g=\|\<gui[fb]g='
	 let nxtlink= substitute(nxtlink,'^[ \t\n]*\(\S\+\)\s\+.*$','\1','')
   	 let hilink = hilink ."->". nxtlink
	 break
	endif
"    call Decho("loop#".no_overflow.": curlink<".curlink."> nxtlink<".nxtlink."> hilink<".hilink.">")
   	let hilink      = hilink ."->". nxtlink
   	let curlink     = nxtlink
   endwhile
"   call Decho("endloop: hilink<".hilink.">")
  endif

  " Use new synstack() function, available with 7.1 and patch#215
  if v:version > 701 || ( v:version == 701 && has("patch215"))
   let syntaxstack = ""
   let isfirst     = 1
   let idlist      = synstack(line("."),col("."))
   if !empty(idlist)
    for id in idlist
     if isfirst
      let syntaxstack= syntaxstack." ".synIDattr(id,"name")
      let isfirst = 0
     else
      let syntaxstack= syntaxstack."->".synIDattr(id,"name")
     endif
    endfor
   endif
  endif

  " display hilink traces
  redraw
  let synid= hlID(lastlink)
  if !exists("syntaxstack")
   echo printf("HltTrace: %-".g:hilinks_fmtwidth."s fg<%s> bg<%s>",hilink,synIDattr(synid,"fg"),synIDattr(synid,"bg"))
  else
   echo printf("SynStack: %-".g:hilinks_fmtwidth."s  HltTrace: %-".g:hilinks_fmtwidth."s fg<%s> bg<%s>",syntaxstack,hilink,synIDattr(synid,"fg"),synIDattr(synid,"bg"))
  endif

  " restore register a
  let @a= keep_rega

  " set up CursorMoved autocmd on bang
  if a:always
   if !s:HLTmode
	" install a CursorMoved highlighting trace
"	call Decho("install CursorMoved HLT")
	let s:HLTmode= 1
	augroup HLTMODE
	 au!
	 au CursorMoved * call s:HiLinkTrace(0)
	augroup END
   else
	" remove the CursorMoved highlighting trace
"	call Decho("remove CursorMoved HLT")
	let s:HLTmode= 0
	augroup HLTMODE
	 au!
	augroup END
	augroup! HLTMODE
   endif
  endif

"  call Dret("HiLinkTrace : hilink<".hilink.">")
endfun

let &cpo= s:keepcpo
" ---------------------------------------------------------------------
" vim: fdm=marker
