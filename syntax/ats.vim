if !exists('main_syntax')
  if exists('b:current_syntax')
      finish
  endif
  let main_syntax = 'ats'
endif

syn keyword atsTodo TODO FIXME contained
syn match atsComment "\v\/\/.*$"
syn region atsNestComment start="(\*" end="\*)" contains=atsNestComment,atsTodo,@Spell

syn match atsIdentifier "\v[a-zA-Z][a-zA-Z_0-9]*"

syn match atsChar "\v'.'"

syn match atsUint "\v[0-9]+u"
syn match atsInt "\v[0-9]+"

syn match atsSpecial +\v\\["nt]+

syn region atsString start=+"+ end=+"+ contains=atsSpecial

syn keyword atsKeyword staload dynload overload with fun symintr include
syn keyword atsKeyword lam llam

syn match atsArrow "\v\=\>+"

syn keyword atsFixity infixr infixl prefix postfix

syn keyword atsType void bool string char int uint charNZ strnptr Strptr0 Strptr1 nat
syn keyword atsType datavtype datatype vtypedef dataviewtype viewtypdef typedef
syn keyword atsType implement primplmnt extern

syn match atsSpecial "\v[@\[\]]"

syn match atsMacro "\v\#.*$"

highlight link atsFixity Underlined
highlight link atsSpecial Special
highlight link atsString String
highlight link atsUint Number
highlight link atsInt Number
highlight link atsChar Character
highlight link atsComment Comment
highlight link atsNestComment Comment
highlight link atsKeyword Keyword
highlight link atsType Type
highlight link atsIdentifier Identifier

let b:current_syntax = 'ats'

if main_syntax ==# 'ats'
    unlet main_syntax
endif

