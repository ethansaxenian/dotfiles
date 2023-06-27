let g:python_highlight_operators = 0
let g:python_highlight_all = 1

setlocal foldmethod=syntax
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let b:undo_ftplugin .= '|setlocal foldmethod<'
let b:undo_ftplugin .= '|setlocal tabstop<'
let b:undo_ftplugin .= '|setlocal shiftwidth<'
let b:undo_ftplugin .= '|setlocal softtabstop<'
let b:undo_ftplugin .= '|setlocal expandtab<'
