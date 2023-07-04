function! StripTrailingWhitespace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

nnoremap <Plug>StripTrailingWhitespace :<C-U>call <SID>StripTrailingWhitespace()<CR>
