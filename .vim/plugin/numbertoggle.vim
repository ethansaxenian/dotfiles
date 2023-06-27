" use relativenumber in insert mode
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != "i" | set relativenumber   | endif
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number                  | set norelativenumber | endif

" toggle between number and relativenumber
function s:ToggleNumber()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

nnoremap <Plug>ToggleNumber :<C-U>call <SID>ToggleNumber()<CR>
