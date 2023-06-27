:syntax sync fromstart
:syntax sync clear

" turn off yats.vim (enabled by default) which adds too many typescript syntax items
let g:yats_host_keyword = 0
let g:typescript_ignore_browserwords = 0

setlocal foldmethod=syntax
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

let b:undo_ftplugin .= '|setlocal foldmethod<'
let b:undo_ftplugin .= '|setlocal tabstop<'
let b:undo_ftplugin .= '|setlocal shiftwidth<'
let b:undo_ftplugin .= '|setlocal softtabstop<'
