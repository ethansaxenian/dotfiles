function s:FzfFiles()
  let s:old_layout = g:fzf_layout

  call system('git rev-parse --is-inside-work-tree 2>/dev/null')
  if v:shell_error == 0
    " show all files in git repository including untracked files, but not gitignore'd files
    call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'git ls-files; git ls-files --others --exclude-standard', 'sink': 'e'})))
  else
    call fzf#vim#files('', fzf#vim#with_preview())
  endif

endfunction


nnoremap <Plug>FzfFiles :<C-U>call <SID>FzfFiles()<CR>

nnoremap <Plug>FzfAllFiles :<C-U>call fzf#vim#files('~', fzf#vim#with_preview())<CR>
