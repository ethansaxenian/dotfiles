function s:FzfFiles(full)
  let s:old_layout = g:fzf_layout

  if a:full
    let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'relative': v:true, 'yoffset': 1.0 }}
  endif

  call system('git rev-parse --is-inside-work-tree 2>/dev/null')
  if v:shell_error == 0
    call fzf#vim#gitfiles('', fzf#vim#with_preview())
  else
    call fzf#vim#files('', fzf#vim#with_preview())
  endif

  let g:fzf_layout = s:old_layout
endfunction


nnoremap <Plug>FzfFiles :<C-U>call <SID>FzfFiles(v:false)<CR>
nnoremap <Plug>FzfFilesFull :<C-U>call <SID>FzfFiles(v:true)<CR>

nnoremap <Plug>FzfAllFiles :<C-U>call fzf#vim#files('~', fzf#vim#with_preview())<CR>
