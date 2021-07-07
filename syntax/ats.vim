scriptencoding utf-8

if !exists('main_syntax')
  if exists('b:current_syntax')
      finish
  endif
  let main_syntax = 'ats'
endif

syn keyword atsTodo TODO FIXME XXX contained

syn match atsIdentifier "\v[a-zA-Z][a-zA-Z_0-9]*"

syn match atsInt "\c\<\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match atsHex "\c\<0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"

" visually marking the leading 0 in octal syntax
syn match atsOctal "\c\<0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=atsOctalZero
syn match atsOctalZero "\<0" contained

" float/double/ldouble, with dot, optional exponent
syn match atsFloat "\c\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
" float/double/ldouble, starting with a dot, optional exponent
syn match atsFloat "\c\i\@<!\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
" float/double/ldouble, without dot, with exponent
syn match atsFloat "\c\d\+e[-+]\=\d\+[fl]\=\>"
" hex float/double/ldouble, optional leading digits, with dot, with exponent
syn match atsHexFloat "\c0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
" hex float/double/ldouble, with leading digits, optional dot, with exponent
syn match atsHexFloat "\c0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"

syn match atsSpecial +\v\\['"nt\\{]+
syn match atsSpecial -\v\\[0-9]+-

syn region atsString start=+"+ end=+"+ contains=atsSpecial
syn keyword atsKeyword staload dynload overload with fun symintr include fn fnx and prfun prfn praxi castfn sortdef
syn keyword atsKeyword as lam llam fix raise of var val prval if then else addr let in begin end when where local while for prvar sif
syn keyword atsKeywordTwo case ifcase scase
syn keyword atsKeyword stadef sta stacst assume macdef exception rec

syn match atsKeyword "\v[\%\+\-\<\>\=!\:\~]+"

syn keyword atsFixity infixr infixl prefix postfix

syn keyword arrowContents cloref1 cloptr1 lincloptr cloref cloptr
syn match atsArrow '=/=>'
syn match atsArrow '=/=>>'

syn region atsArrow start="=<" end=">" contains=arrowContents
syn region atsArrow start="-<" end=">"

syn keyword atsType void bool string char int uint uint8 uint32 uint16 int8 int32 int16 charNZ strnptr Strptr0 Strptr1 nat lint ulint double float size_t
syn keyword atsType datavtype datatype vtypedef dataviewtype viewtypdef typedef view viewdef dataview abstype absvtype absviewtype absview datasort dataprop type viewtype vtype propdef prop
syn keyword atsType absimpl absprop
syn keyword atsType implement primplmnt extern

syn match atsParens "[()]"

syn match atsOperator "\v[\@\'\#]"

syn region atsMacro start="\v^#" end="\v$" contains=atsString

syn keyword atsBool true false

syn region atsComment start="\/\/" end="$" contains=atsTodo,@Spell
syn region atsNestComment start="/\*" end="\*/" contains=atsNestComment,atsTodo,@Spell
syn region atsNestParenComment start="(\*" end="\*)" contains=atsTodo,@Spell,atsNestParenComment
syn region atsRestOfFileComment start="////" end="\%$" contains=atsTodo,@Spell

syntax match logicalAnd '&&' conceal cchar=∧
syntax match leq '<=' conceal cchar=≤
syntax match geq '>=' conceal cchar=≥
syntax match neq '!=' conceal cchar=≠
syntax match seq '==' conceal cchar=≡
syntax match logicalOr '||' conceal cchar=∨
syntax match nullPtr 'null' conceal cchar=∅

syn match atsChar "\v'.'"
syn match atsChar "\v'.*'" contains=atsSpecial
syn match atsPattern "\v'\("

syn include @c syntax/c.vim
syn region cBlock matchgroup=atsCBlock start="%{\|%{^\|%{#" end="%}" contains=@c

highlight link Conceal Keyword

highlight link atsBool Boolean
highlight link atsString String
highlight link atsFloat Float
highlight link atsHexFloat Float
highlight link atsInt Number
highlight link atsOctal Number
highlight link atsOctalZero SpecialChar
highlight link atsHex Number
highlight link atsChar Character

highlight link atsKeywordTwo Include
highlight link atsArrow Special
highlight link atsFixity Underlined
highlight link atsOperator Special
highlight link atsSpecial Special
highlight link atsKeyword Keyword
highlight link atsType Type
highlight link atsIdentifier Identifier

highlight link atsComment Comment
highlight link atsNestComment Comment
highlight link atsNestParenComment Comment
highlight link atsRestOfFileComment Comment
highlight link atsTodo Todo

hi def link atsCBlock Special

setlocal conceallevel=1

let b:current_syntax = 'ats'

if main_syntax ==# 'ats'
    unlet main_syntax
endif

