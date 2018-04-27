scriptencoding utf-8

if !exists('main_syntax')
  if exists('b:current_syntax')
      finish
  endif
  let main_syntax = 'ats'
endif

syn keyword atsTodo TODO FIXME contained
syn match atsIdentifier "\v[a-zA-Z][a-zA-Z_0-9]*"

syn match atsInt "\v[0-9]+"
syn match atsUint "\v[0-9]+u"

syn match atsSpecial +\v\\["nt\\]+
syn match atsSpecial -\v\\[0-9]+-

syn region atsString start=+"+ end=+"+ contains=atsSpecial
syn keyword atsKeyword staload dynload overload with fun symintr include fn fnx and prfun prfn praxi castfn sortdef
syn keyword atsKeyword lam llam fix raise of var val prval if then else addr let in begin end when where local
syn keyword atsKeywordTwo case ifcase
syn keyword atsKeyword stadef sta stacst assume macdef

syn match atsKeyword "\v[\%\+\-\<\>\=!\:\~]+"

syn keyword atsFixity infixr infixl prefix postfix

syn keyword arrowContents cloref1 cloptr1 lincloptr cloref cloptr
syn match atsArrow '=/=>'

syn region atsArrow start="=<" end=">" contains=arrowContents
syn region atsArrow start="-<" end=">"

syn keyword atsType void bool string char int uint charNZ strnptr Strptr0 Strptr1 nat lint ulint double float
syn keyword atsType datavtype datatype vtypedef dataviewtype viewtypdef typedef view viewdef dataview abstype absvtype absviewtype datasort dataprop
syn keyword atsType implement primplmnt extern

syn match atsParens "[()]"

syn match atsOperator "\v[\@\'\#]"

syn region atsMacro start="\v^#" end="\v$" contains=atsString

syn keyword atsBool true false

syn match atsComment "\v\/\/.*$" contains=atsTodo,@Spell
syn region atsNestComment start="/\*" end="\*/" contains=atsNestComment,atsTodo,@Spell
syn region atsNestParenComment start="(\*" end="\*)" contains=atsTodo,@Spell,atsNestParenComment

syntax match logicalAnd '&&' conceal cchar=∧
syntax match leq '<=' conceal cchar=≤
syntax match geq '>=' conceal cchar=≥
syntax match neq '!=' conceal cchar=≠
syntax match logicalOr '||' conceal cchar=∨

syn match atsChar "\v'.'"
syn match atsChar "\v'.*'" contains=atsSpecial
syn match atsSpecial "\v'\("

syn include @c syntax/c.vim
syn region cBlock matchgroup=atsCBlock start="%{\|%{^\|%{#" end="%}" contains=@c

highlight link Conceal Keyword
highlight link atsBool Boolean
highlight link atsKeywordTwo Include
highlight link atsArrow Special
highlight link atsFixity Underlined
highlight link atsOperator Special
highlight link atsSpecial Special
highlight link atsString String
highlight link atsUint Number
highlight link atsInt Number
highlight link atsChar Character
highlight link atsComment Comment
highlight link atsNestComment Comment
highlight link atsNestParenComment Comment
highlight link atsKeyword Keyword
highlight link atsType Type
highlight link atsIdentifier Identifier

hi def link atsCBlock Special

setlocal conceallevel=1

let b:current_syntax = 'ats'

if main_syntax ==# 'ats'
    unlet main_syntax
endif

