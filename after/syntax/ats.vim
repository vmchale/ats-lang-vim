scriptencoding utf-8

syntax match logicalAnd '&&' conceal cchar=∧
syntax match leq '<=' conceal cchar=≤
syntax match geq '>=' conceal cchar=≥
syntax match logicalOr '||' conceal cchar=∨

" FIXME boring white?
hi! link Conceal Keyword

setlocal conceallevel=1
