set background=dark
highlight clear
syntax reset

let g:colors_name="mycolors"
let colors_name="mycolors"


let s:black       = { "gui": "#000000", "cterm": "0"   }
let s:red         = { "gui": "#e06c75", "cterm": "168" }
let s:green       = { "gui": "#87af5f", "cterm": "107" }
let s:forestgreen = { "gui": "#00af87", "cterm": "36"  }
let s:yellow      = { "gui": "#ffffaf", "cterm": "229" }
let s:dullyellow  = { "gui": "#ffffd7", "cterm": "230" }
let s:deeporange  = { "gui": "#d78700", "cterm": "172" }
let s:orange      = { "gui": "#ffaf87", "cterm": "216" }
let s:lightorange = { "gui": "#ffd787", "cterm": "222" }
let s:darkblue    = { "gui": "#0087ff", "cterm": "33"  }
let s:blue        = { "gui": "#61afef", "cterm": "75"  }
let s:lightblue   = { "gui": "#6897BB", "cterm": "153" }
let s:purple      = { "gui": "#c678dd", "cterm": "176" }
let s:softpurple  = { "gui": "#8282BB", "cterm": "104" }
let s:brightpink  = { "gui": "#af5faf", "cterm": "164" }
let s:pink		  = { "gui": "#af5faf", "cterm": "133" }
let s:cyan        = { "gui": "#56b6c2", "cterm": "73"  }
let s:white       = { "gui": "#ffffff", "cterm": "15"  }

let s:fg          = { "gui": "#dcdfe4", "cterm": "188" }
let s:bg          = { "gui": "#1c1c1c", "cterm": "234" }

let s:comment_fg  = { "gui": "#8a8a8a", "cterm": "245" }
let s:gutter_bg   = s:bg
let s:gutter_fg   = { "gui": "#919baa", "cterm": "247" }
let s:non_text    = { "gui": "#373C45", "cterm": "239" }

let s:cursor_line = { "gui": "#313640", "cterm": "237" }
let s:color_col   = { "gui": "#313640", "cterm": "237" }

let s:selection   = { "gui": "#474e5d", "cterm": "239" }
let s:vertsplit   = { "gui": "#313640", "cterm": "237" }

let s:search      = { "gui": "#afd7ff", "cterm": "153" }

function! s:h(group, fg, bg, attr)
  if type(a:fg) == type({})
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
  else
    exec "hi " . a:group . " guifg=NONE cterm=NONE"
  endif
  if type(a:bg) == type({})
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
  else
    exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  else
    exec "hi " . a:group . " gui=NONE cterm=NONE"
  endif
endfun


" User interface colors {{{
call s:h("Normal", s:fg, s:bg, "")

call s:h("Cursor", s:bg, s:blue, "")
call s:h("CursorColumn", "", s:cursor_line, "")
call s:h("CursorLine", "", s:cursor_line, "")

call s:h("LineNr", s:gutter_fg, s:gutter_bg, "")
call s:h("CursorLineNr", s:fg, "", "")

call s:h("DiffAdd", s:green, "", "")
call s:h("DiffChange", s:orange, "", "")
call s:h("DiffDelete", s:red, "", "")
call s:h("DiffText", s:blue, "", "")

call s:h("IncSearch", s:bg, s:search, "")
call s:h("Search", s:bg, s:search, "")

call s:h("ErrorMsg", s:fg, "", "")
call s:h("ModeMsg", s:fg, "", "")
call s:h("MoreMsg", s:fg, "", "")
call s:h("WarningMsg", s:red, "", "")
call s:h("Question", s:purple, "", "")

call s:h("Pmenu", s:bg, s:fg, "")
call s:h("PmenuSel", s:fg, s:blue, "")
call s:h("PmenuSbar", "", s:selection, "")
call s:h("PmenuThumb", "", s:fg, "")

call s:h("SpellBad", s:red, "", "")
call s:h("SpellCap", s:orange, "", "")
call s:h("SpellLocal", s:orange, "", "")
call s:h("SpellRare", s:orange, "", "")

call s:h("StatusLine1", s:red, s:cursor_line, "")
call s:h("StatusLine2", s:purple, s:cursor_line, "")
call s:h("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:h("TabLine", s:comment_fg, s:cursor_line, "")
call s:h("TabLineFill", s:comment_fg, s:cursor_line, "")
call s:h("TabLineSel", s:fg, s:bg, "")

call s:h("Visual", "", s:selection, "")
call s:h("VisualNOS", "", s:selection, "")

call s:h("ColorColumn", "", s:color_col, "")
call s:h("Conceal", s:fg, "", "")
call s:h("Directory", s:blue, "", "")
call s:h("VertSplit", s:vertsplit, s:vertsplit, "")
call s:h("Folded", s:fg, "", "")
call s:h("FoldColumn", s:fg, "", "")
call s:h("SignColumn", s:fg, "", "")

call s:h("MatchParen", s:darkblue, s:cursor_line, "")
call s:h("SpecialKey", s:fg, "", "")
call s:h("Title", s:green, "", "")
call s:h("WildMenu", s:fg, "", "")
" }}}
" Syntax colors {{{
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:h("Whitespace", s:non_text, "", "")
call s:h("NonText", s:non_text, "", "")
call s:h("Comment", s:comment_fg, "", "")
call s:h("Constant", s:cyan, "", "")
call s:h("String", s:orange, "", "")
call s:h("Character", s:green, "", "")
call s:h("Number", s:yellow, "", "")
call s:h("Boolean", s:yellow, "", "")
call s:h("Float", s:yellow, "", "")

call s:h("Identifier", s:red, "", "")
call s:h("Function", s:blue, "", "")
call s:h("Statement", s:purple, "", "")

call s:h("Conditional", s:purple, "", "")
call s:h("Repeat", s:purple, "", "")
call s:h("Label", s:purple, "", "")
call s:h("Operator", s:fg, "", "")
call s:h("Keyword", s:red, "", "")
call s:h("Exception", s:purple, "", "")

call s:h("PreProc", s:yellow, "", "")
call s:h("Include", s:purple, "", "")
call s:h("Define", s:purple, "", "")
call s:h("Macro", s:purple, "", "")
call s:h("PreCondit", s:yellow, "", "")

call s:h("Type", s:yellow, "", "")
call s:h("StorageClass", s:yellow, "", "")
call s:h("Structure", s:yellow, "", "")
call s:h("Typedef", s:yellow, "", "")

call s:h("Special", s:blue, "", "")
call s:h("SpecialChar", s:fg, "", "")
call s:h("Tag", s:fg, "", "")
call s:h("Delimiter", s:fg, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug", s:fg, "", "")
call s:h("Underlined", s:fg, "", "")
call s:h("Ignore", s:fg, "", "")
call s:h("Error", s:red, s:gutter_bg, "")
call s:h("Todo", s:purple, "", "")
" }}}
" C Syntax {{{
" goto break return continue asm
call s:h("cStatement", s:purple, "", "")
" case default
call s:h("cLabel", s:purple, "", "")
" if else switch
call s:h("cConditional", s:purple, "", "")
" while for do
call s:h("cRepeat", s:purple, "", "")

call s:h("cString", s:orange, "", "")
" % items in strings
call s:h("cFormat", s:lightblue, "", "")
call s:h("cSpecial", s:lightorange, "", "")
call s:h("cSpecialCharacter", s:lightorange, "", "")

call s:h("cNumber", s:dullyellow, "", "")
call s:h("cFloat", s:dullyellow, "", "")

call s:h("cCommentStart", s:green, "", "")
call s:h("cComment", s:green, "", "")
call s:h("cCommentL", s:green, "", "")

" sizeof typeof
call s:h("cOperator", s:blue, "", "")
" static register auto volatile extern const
call s:h("cStorageClass", s:blue, "", "")
" int long short char void signed unsigned float double ...
call s:h("cType", s:blue, "", "")
" typedef
call s:h("cTypedef", s:blue, "", "")
" struct union enum
call s:h("cStructure", s:blue, "", "")
" . or -> syntax
call s:h("cStructMember", s:lightblue, "", "")
" NULL ...
call s:h("cConstant", s:blue, "", "")

call s:h("cDefine", s:purple, "", "")
call s:h("cInclude", s:purple, "", "")
call s:h("cIncluded", s:orange, "", "")
call s:h("cUserFunction", s:yellow, "", "")

call s:h("cAnsiName", s:fg, "", "")
call s:h("cTodo", s:bg, s:fg, "")
" }}}
" Python Syntax {{{
" break continue del return pass yield global assert lambda with raise def class
call s:h("pythonStatement", s:deeporange, "", "")
" self class
call s:h("pythonClassVar", s:pink, "", "")
" for while
call s:h("pythonRepeat", s:deeporange, "", "")
" if elif else
call s:h("pythonConditional", s:deeporange, "", "")
"	try except finally
call s:h("pythonException", s:deeporange, "", "")
" import as from
call s:h("pythonImport", s:deeporange, "", "")

call s:h("pythonClass", s:fg, "", "")
call s:h("pythonFunction", s:lightorange, "", "")
call s:h("pythonFunctionCall", s:fg, "", "")

"and in is not or
call s:h("pythonOperator", s:deeporange, "", "")

call s:h("pythonDecorator", s:dullyellow, "", "")
call s:h("pythonDecoratorName", s:dullyellow, "", "")
call s:h("pythonDottedName", s:dullyellow, "", "")

call s:h("pythonComment", s:comment_fg, "", "")
call s:h("pythonTodo", s:bg, s:fg, "")
call s:h("pythonTripleQuotes", s:green, "", "")

call s:h("pythonQuotes", s:green, "", "")
call s:h("pythonString", s:green, "", "")
call s:h("pythonFString", s:green, "", "")
call s:h("pythonStrFormat", s:deeporange, "", "")
call s:h("pythonStrFormatting", s:green, "", "")
call s:h("pythonStrTemplate", s:green, "", "")
call s:h("pythonBytesEscape", s:deeporange, "", "")
call s:h("pythonStrInterpRegion", s:fg, "", "")

call s:h("pythonNumber", s:lightblue, "", "")
call s:h("pythonFloat", s:lightblue, "", "")

" None
call s:h("pythonNone", s:deeporange, "", "")
" True False
call s:h("pythonBoolean", s:deeporange, "", "")
" NotImplemented
call s:h("pythonSingleton", s:softpurple, "", "")
" __debug__ __doc__ __file__ __name__ __package__ ...
call s:h("pythonBuiltinObj", s:brightpink, "", "")
" object bool int float tuple str list dict set frozenset
call s:h("pythonBuiltinType", s:softpurple, "", "")
call s:h("pythonBuiltinFunc", s:softpurple, "", "")
call s:h("pythonBuiltin", s:softpurple, "", "")
call s:h("pythonExClass", s:softpurple, "", "")
" }}}
" Javascript Syntax {{{
call s:h("jsImport", s:purple, "", "")
call s:h("jsExport", s:purple, "", "")
call s:h("jsExportDefault", s:purple, "", "")
call s:h("jsFrom", s:purple, "", "")
call s:h("jsModuleKeyword", s:lightblue, "", "")
call s:h("jsOperatorKeyword", s:darkblue, "", "")
call s:h("jsExceptions", s:forestgreen, "", "")

call s:h("jsString", s:orange, "", "")
call s:h("jsTemplateString", s:orange, "", "")

call s:h("jsComment", s:green, "", "")

call s:h("jsNumber", s:dullyellow, "", "")
call s:h("jsFloat", s:dullyellow, "", "")

call s:h("jsBooleanTrue", s:darkblue, "", "")
call s:h("jsBooleanFalse", s:darkblue, "", "")

call s:h("jsAsyncKeyword", s:darkblue, "", "")
call s:h("jsForAwait", s:purple, "", "")

call s:h("jsSpecial", s:red, "", "")
call s:h("jsTemplateExpression", s:blue, "", "")
call s:h("jsRegexpBoundary", s:yellow, "", "")
call s:h("jsRegexpQuantifier", s:orange, "", "")
call s:h("jsRegexpOr", s:yellow, "", "")
call s:h("jsRegexpGroup", s:orange, "", "")
call s:h("jsRegexpString", s:blue, "", "")

call s:h("jsObjectProp", s:lightblue, "", "")
call s:h("jsObjectShorthandProp", s:lightblue, "", "")
call s:h("jsObjectKey", s:lightblue, "", "")
call s:h("jsObjectKeyComputed", s:blue, "", "")
call s:h("jsObjectValue", s:blue, "", "")
call s:h("jsFunction", s:darkblue, "", "")
call s:h("jsFuncName", s:yellow, "", "")
call s:h("jsFuncCall", s:yellow, "", "")
call s:h("jsFuncArgs", s:lightblue, "", "")
call s:h("jsArrowFunction", s:darkblue, "", "")
call s:h("jsFuncBlock", s:blue, "", "")

call s:h("jsConditional", s:purple, "", "")
call s:h("jsReturn", s:purple, "", "")

call s:h("jsIfElseBlock", s:blue, "", "")
call s:h("jsTernaryIf", s:blue, "", "")
call s:h("jsParen", s:lightblue, "", "")
call s:h("jsParenRepeat", s:lightblue, "", "")
call s:h("jsRepeatBlock", s:blue, "", "")
call s:h("jsParenIfElse", s:lightblue, "", "")
call s:h("jsBracket", s:lightblue, "", "")
call s:h("jsTemplateBraces", s:darkblue, "", "")

call s:h("jsStorageClass", s:darkblue, "", "")
call s:h("jsVariableDef", s:blue, "", "")
call s:h("jsDestructuringPropertyValue", s:blue, "", "")
call s:h("jsDestructuringBlock", s:lightblue, "", "")
call s:h("jsSpreadExpression", s:blue, "", "")

call s:h("jsGlobalObjects", s:lightblue, "", "")
call s:h("jsGlobalNodeObjects", s:forestgreen, "", "")
call s:h("jsBuiltins", s:yellow, "", "")

call s:h("jsxComponentName", s:forestgreen, "", "")
call s:h("jsxBraces", s:darkblue, "", "")
call s:h("jsxExpressionBlock", s:blue, "", "")
call s:h("jsxAttrib", s:lightblue, "", "")
call s:h("jsxElement", s:fg, "", "")
call s:h("jsxTagName", s:blue, "", "")
" }}}
" Css Syntax {{{
call s:h("cssBraces", s:fg, "", "")
call s:h("cssFunctionName", s:yellow, "", "")
call s:h("cssFunctionComma", s:fg, "", "")
call s:h("cssAttrComma", s:fg, "", "")
call s:h("cssComment", s:green, "", "")
call s:h("cssHacks", s:blue, "", "")
call s:h("cssImportant", s:blue, "", "")
call s:h("cssAtRule", s:purple, "", "")

call s:h("cssClassName", s:lightorange, "", "")
hi! link cssClassNameDot cssClassName
hi! link cssPseudoClassId cssClassName
hi! link cssPseudoClass cssClassName
hi! link cssTagName cssClassName
hi! link cssVendor cssClassName

call s:h("cssColor", s:orange, "", "")
hi! link cssAttrRegion cssColor
hi! link cssFontAttr cssColor
hi! link cssFlexibleBoxAttr cssColor
hi! link cssCommonAttr cssColor
hi! link cssBorderAttr cssColor
hi! link cssUIAttr cssColor
hi! link cssBoxAttr cssColor
hi! link cssMediaAttr cssColor
hi! link cssMultiColumnAttr cssColor
hi! link cssTextAttr cssColor
hi! link cssFunction cssColor
hi! link cssPositioningAttr cssColor
hi! link cssTransitionAttr cssColor
hi! link cssAnimationAttr cssColor

call s:h("cssBoxProp", s:lightblue, "", "")
hi! link cssListProp cssBoxProp
hi! link cssMediaProp cssBoxProp
hi! link cssBackgroundProp cssBoxProp
hi! link cssBorderProp cssBoxProp
hi! link cssFontProp cssBoxProp
hi! link cssTextProp cssBoxProp
hi! link cssUIProp cssBoxProp
hi! link cssTransitionProp cssBoxProp
hi! link cssPositioningProp cssBoxProp
hi! link cssFlexibleBoxProp cssBoxProp
hi! link cssTransformProp cssBoxProp
hi! link cssAnimationProp cssBoxProp
hi! link cssCustomProp cssBoxProp

call s:h("cssValueNumber", s:dullyellow, "", "")
hi! link cssValueTime cssValueNumber
hi! link cssUnitDecorators cssValueNumber
hi! link cssValueLength cssValueNumber
" }}}
" Json Syntax {{{
call s:h("jsonKeyword", s:lightblue, "", "")
call s:h("jsonString", s:orange, "", "")
call s:h("jsonBoolean", s:blue, "", "")
call s:h("jsonNull", s:blue, "", "")
call s:h("jsonNumber", s:yellow, "", "")
" }}}
" Markdown Syntax {{{
call s:h("mkdDelimiter", s:fg, "", "")
call s:h("mkdLink", s:orange, "", "")
call s:h("mkdURL", s:fg, "", "")
call s:h("mkdHeading", s:blue, "", "bold")
call s:h("htmlH3", s:blue, "", "bold")
call s:h("htmlH2", s:blue, "", "bold")
call s:h("htmlH1", s:blue, "", "bold")
call s:h("mkdListItem", s:blue, "", "")
call s:h("mkdCodeDelimiter", s:orange, "", "")
call s:h("mkdCode", s:orange, "", "")
" }}}
" Makefile Syntax {{{
call s:h("makeTarget", s:yellow, "", "")
call s:h("makeSpecTarget", s:yellow, "", "")
call s:h("makeStatement", s:yellow, "", "")
call s:h("makeCommands", s:fg, "", "")
call s:h("makeComment", s:green, "", "")
call s:h("makeIdent", s:lightblue, "", "")
" }}}
" Yaml Syntax {{{
call s:h("yamlFlowString", s:orange, "", "")
call s:h("yamlFlowStringDelimiter", s:orange, "", "")
call s:h("yamlBlockMappingKey", s:blue, "", "")
call s:h("yamlInteger", s:yellow, "", "")
call s:h("yamlKeyValueDelimiter", s:fg, "", "")
call s:h("yamlBlockCollectionItemStart", s:fg, "", "")
call s:h("yamlComment", s:green, "", "")
call s:h("yamlFlowIndicator", s:fg, "", "")
call s:h("yamlPlainScalar", s:orange, "", "")
" }}}
