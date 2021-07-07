if exists('b:ats_ftplugin')
	finish
endif
let b:ats_ftplugin = 1

if !exists('g:ats_use_ctags')
    let g:ats_use_ctags = 0
endif

" set config values
if !exists('g:ats_autoformat')
    if executable('atsfmt') == 1
        let g:ats_autoformat = 1
    else
        let g:ats_autoformat = 0
    endif
endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

setlocal comments=sr:/*,mb:*,ex:*/,sr:(*,mb:*,ex:*)

" indentation rules
set smarttab
augroup ats
    au BufNewFile,BufRead *.*ats setl shiftwidth=2
augroup END

" set comment string to something prettier
setlocal commentstring=(*\ %s\ *)

" use patscc as a checker
let g:syntastic_ats_checkers = [ 'patscc' ]

" function to format our buffer
function! AtsFormat()
    let cursor = getpos('.')
    exec 'normal! gg'
    exec 'silent !atsfmt -i ' . expand('%')
    exec 'e'
    call setpos('.', cursor)
endfunction

if g:ats_use_ctags == 1
    augroup ats
        autocmd BufWritePost *.dats,*.cats,*.sats,*.hats silent !ctags -R .
    augroup END
endif

" format on write
if g:ats_autoformat == 1
    augroup ats
        autocmd BufWritePost *.dats,*.sats,*.hats call AtsFormat()
    augroup END
endif

" commands
command! -nargs=0 Format call AtsFormat()

map <Plug>Clear :SyntasticReset<CR>
