setlocal foldmethod=syntax
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

let b:undo_ftplugin .= '|setlocal foldmethod<'
let b:undo_ftplugin .= '|setlocal tabstop<'
let b:undo_ftplugin .= '|setlocal shiftwidth<'
let b:undo_ftplugin .= '|setlocal softtabstop<'
