if !exists('main_syntax')
  if exists('b:current_syntax')
      finish
  endif
  let main_syntax = 'ats'
endif

syn keyword atsTodo TODO FIXME contained
syn match atsComment "\v\/\/.*$"
syn region atsNestComment start="(\*" end="\*)" contains=atsNestComment,atsTodo,@Spell

syn keyword atsKeyword staload overload with fun

syn keyword atsType void bool string char int uint charNZ strnptr Strptr0 Strptr1

highlight link atsComment Comment
highlight link atsNestComment Comment
highlight link atsKeyword Keyword
highlight link atsType Type

let b:current_syntax = 'ats'

if main_syntax ==# 'ats'
    unlet main_syntax
endif

