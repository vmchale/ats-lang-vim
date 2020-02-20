scriptencoding utf-8

if !exists('main_syntax')
  if exists('b:current_syntax')
      finish
  endif
  let main_syntax = 'ats'
endif

syn iskeyword @,48-57,192-255,$,*,_,@-@

syn keyword atsTodo TODO FIXME XXX contained

syn match atsIdentifier "\(\w\|\$\)\@<!\h\(\w\|\$\|\'\)*"

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

syn match atsSpecial "\\[abfnrtv]" contained
syn match atsSpecial "\\['\"?\\{}()\[\]]" contained
syn match atsSpecial "\\\o\{1,3}" contained
syn match atsSpecial "\\[xX][0-9A-F]\{1,2}" contained

syn match atsChar "\i\@<!'[^\\]'"
syn match atsChar "\i\@<!'\\[^']*'" contains=atsSpecial

syn region atsString start=+"+ end=+"+ contains=atsSpecial

syn match atsAtOperator "@[({[]\@!"
syn match atsPercOperator "%[({}]\@!"

syn region atsParens start="['@`,%]\@<!(" end=")" contains=TOP

syn region atsTupBoxed start="'(" end=")" contains=TOP
syn region atsTupFlat start="@(" end=")" contains=TOP

syn region atsRecBoxed start="'{" end="}" contains=TOP
syn region atsRecFlat start="@{" end="}" contains=TOP

syn region atsArrFlat matchgroup=atsArrFlat start="@\[" end="]" contains=TOP nextgroup=atsArrFlatSize,atsArrFlatElts
syn region atsArrFlatSize matchgroup=atsArrFlat start="\[" end="]" nextgroup=atsArrFlatElts contains=TOP contained
syn region atsArrFlatElts matchgroup=atsArrFlat start="(" end=")" contains=TOP contained

syn region atsExQuantLeft matchgroup=atsExQuant start="#\[" end="]\||\@=" nextgroup=atsExQuantRight contains=TOP
syn region atsExQuantRight matchgroup=atsExQuant start="|" end="]" contains=TOP contained

syn match atsKeyword "\v[\+\-\<\>\=!\:\~]+"

syn region atsLoadPath start=+"+ end=+"+ contains=atsLoadPathHomeLocs,atsLoadPathNgurl contained keepend
syn match atsLoadPathHomeLocs "\"\@<=\$PATSHOMELOCS" contained
syn region atsLoadPathNgurl start="\"\@<={" end="}" contained

syn match atsStaload "^#\=staload" nextgroup=atsStaloadDecl,atsStaloadNS,atsLoadPath skipwhite skipnl
syn match atsStaloadDecl "\<\(\w\|\$\|\'\)\+\s*=" nextgroup=atsStaloadNS,atsLoadPath contained skipwhite
syn match atsStaloadNS "\<\$\(\w\|\$\|\'\)\+" contained

syn match atsDynload "^#\=dynload" nextgroup=atsLoadPath skipwhite skipnl
syn match atsInclude "^#include" nextgroup=atsLoadPath skipwhite skipnl
syn match atsRequire "^#require" nextgroup=atsLoadPath skipwhite skipnl

syn match atsDefine "#define\>"
syn match atsUndefine "#undef\>"

syn keyword atsDefineSpecial ATS_PACKNAME ATS_EXTERN_PREFIX ATS_STATIC_PREFIX
syn keyword atsDefineSpecial ATS_DYNLOADFLAG ATS_DYNLOADNAME ATS_MAINATSFLAG

syn match atsPreCondit "#if\(def\|ndef\)\=\>"
syn match atsPreCondit "#elif\(def\|ndef\)\=\>"
syn match atsPreCondit "#then\>"
syn match atsPreCondit "#else\>"
syn match atsPreCondit "#endif\>"

syn match atsPreProc "#error\>"
syn match atsPreProc "#prerr\>"
syn match atsPreProc "#print\>"
syn match atsPreProc "#assert\>"
syn match atsPreProc "#pragma\>"

syn match atsNamespace "\<\$[a-zA-Z0-9_]*\.\@="


syn keyword atsMacroDefine macdef macrodef
syn region atsMacroEncode start="`(" end=")" contains=TOP
syn region atsMacroDecode start=",(" end=")" contains=TOP
syn region atsMacroXStage start="%(" end=")" contains=TOP

syn keyword atsConditional ifcase if then else case sif scase
syn keyword atsException $raise raise try with

syn keyword atsRepeat while while* for for*
syn keyword atsKeyword $break $continue

syn keyword atsDebug $myfilename $myfunction $mylocation $showtype

syn keyword atsFun lam lam@ llam fix fix@
syn keyword atsFun fun fn fnx prfun prfn
syn keyword atsFun castfn praxi

syn keyword atsKeyword overload symintr
syn keyword atsKeyword and as of let in begin end when where local
syn keyword atsKeyword var val prval prvar extvar
syn keyword atsKeyword $extval $extfcall $extmcall $vararg
syn keyword atsKeyword sizeof exception rec
syn match atsKeyword "\(fold\|free\|view\|addr\)@"

syn keyword atsKeyword lnot lor land lxor not xor
syn keyword atsKeyword mod nmod ndiv
syn keyword atsKeyword andalso orelse

syn keyword atsFixity infix infixr infixl nonfix prefix postfix

syn match atsCaseArrow '=>>\='
syn match atsCaseUnreachable '=/=>>\='

" These are the tags that are allowed in between -<>/:<>/=<>
syn keyword atsFunTag fun clo cloptr cloref lin linfun linclo lincloptr prf contained
syn keyword atsFunTag fun0 clo0 cloptr0 cloref0 lin0 linfun0 linclo0 lincloptr0 contained
syn keyword atsFunTag fun1 clo1 cloptr1 cloref1 lin1 linfun1 linclo1 lincloptr1 contained

" These are the effect tags that are allowed in between -<>/:<>/=<>
syn keyword atsEffTag nil all ntm nonterm exn exception ref reference wrt write contained
syn keyword atsEffTag exnref exnwrt exnrefwrt refwrt laz contained

" These are the effect static constant identifiers
syn keyword atsEffCst effnil effall effntm effexn effref effwrt

syn match atsEffOps "[~!]" contained

syn cluster atsEffList contains=atsFunTag,atsEffTag,atsEffOps,atsInt,atsIdentifier

syn keyword atsEffmask $effmask $effmask_all $effmask_exn $effmask_ref $effmask_wrt
syn keyword atsEffmask $effmask nextgroup=atsEffmaskArg skipwhite skipnl
syn region atsEffmaskArg start="{" end="}" contains=@atsEffList contained

syn region atsArrow start="[-:=]<" end=">" contains=@atsEffList

syn keyword atsType addr agz agez alez
syn keyword atsType void real cls eff tkind types
syn keyword atsType charNZ scharNZ ucharNZ
syn keyword atsType sint usint lint ulint llint ullint double ldouble float pos
syn keyword atsType size_t ssize_t
syn keyword atsType Size_t SSize_t Size SSize
syn keyword atsType int8 uint8 int16 uint16 int32 uint32 int64 uint64
syn keyword atsType Int8 uInt8 Int16 uInt16 Int32 uInt32 Int64 uInt64
syn keyword atsType bool ptr int uint nat char schar uchar string
syn keyword atsType Bool Ptr Int uInt Nat Char sChar uChar String Sgn
syn keyword atsType intptr uintptr strptr strnptr Strptr Strnptr
syn keyword atsType Strptr0 Strptr1 Strnptr0 Strnptr1
syn keyword atsType vtflt viewt@ype vt@ype viewt0ype vt0ype
syn keyword atsType vtbox viewtype vtype
syn keyword atsType tflt t@ype t0ype
syn keyword atsType tbox type
syn keyword atsType prop view

syn keyword atsStructure datavtype datatype dataviewtype dataview datasort dataprop

syn keyword atsTypedef sta stacst stadef sexpdef
syn keyword atsTypedef typedef viewtypedef vtypedef
syn keyword atsTypedef classdec propdef sortdef tkindef viewdef

syn keyword atsTypedefAbs absvtflt absvtflat absviewt@ype absvt@ype absviewt0ype absvt0ype
syn keyword atsTypedefAbs absvtbox absviewtype absvtype
syn keyword atsTypedefAbs abstflt abstflat abst@ype abst0ype
syn keyword atsTypedefAbs abstbox abstype
syn keyword atsTypedefAbs absprop absview

syn keyword atsTypedefExt $extkind $extype $extype_struct

syn keyword atsType absimpl absreimpl assume reassume
syn keyword atsType implement implmnt primplement primplmnt extern static
syn keyword atsType withprop withtype withview withvtype withviewtype

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
syntax match atsNullPtr '\<null\>' conceal cchar=∅

syn include @c syntax/c.vim
syn region cBlock matchgroup=atsCBlock start="%{[#^$]\=" end="%}" contains=@c

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
highlight link atsSpecial SpecialChar
highlight link atsNullPtr Constant

highlight link atsRecBoxed atsRecord
highlight link atsTupBoxed atsTuple
highlight link atsRecFlat atsRecord
highlight link atsTupFlat atsTuple
highlight link atsArrFlat atsArray

highlight link atsAtOperator Special
highlight link atsPercOperator Operator

highlight link atsCaseArrow Keyword
highlight link atsCaseUnreachable Special

highlight link atsStaload Include
highlight link atsDynload Include
highlight link atsInclude Include
highlight link atsRequire Include
highlight link atsLoadPath String
highlight link atsLoadPathHomeLocs Special
highlight link atsLoadPathNgurl Special

highlight link atsDefine Define
highlight link atsUndefine Define
highlight link atsPreCondit PreCondit
highlight link atsPreProc PreProc
highlight link atsDefineSpecial PreProc

highlight link atsMacroDefine Define
highlight link atsMacroEncode Macro
highlight link atsMacroDecode Macro
highlight link atsMacroXStage Macro

highlight link atsConditional Conditional
highlight link atsDebug Debug
highlight link atsRepeat Repeat
highlight link atsException Exception
highlight link atsFun Keyword

highlight link atsEffmask Statement
highlight link atsFunTag Constant
highlight link atsEffTag Constant
highlight link atsEffCst Constant
highlight link atsEffOps Operator
highlight link atsArrow Special
highlight link atsFixity Underlined
highlight link atsKeyword Keyword
highlight link atsIdentifier Identifier

highlight link atsStructure Structure
highlight link atsType Type
highlight link atsTypedef Typedef
highlight link atsTypedefAbs atsTypedef
highlight link atsTypedefExt atsTypedef

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

