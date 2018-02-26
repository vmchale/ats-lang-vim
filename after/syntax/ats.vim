scriptencoding utf-8

syntax match logicalAnd '&&' conceal cchar=∧
syntax match leq '<=' conceal cchar=≤
syntax match geq '>=' conceal cchar=≥
syntax match neq '!=' conceal cchar=≠
syntax match logicalOr '||' conceal cchar=∨

" FIXME boring white?
hi! link Conceal Keyword

" store and remove current syntax value
let old_syntax = b:current_syntax
unlet b:current_syntax

syn include @c syntax/c.vim
unlet b:current_syntax

syn region madBlock matchgroup=atsCBlock start="%{" end="%}" contains=@c

hi def link atsCBlock Special

" restore current syntax value
let b:current_syntax = old_syntax

setlocal conceallevel=1
