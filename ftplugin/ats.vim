if exists('b:ats_ftplugin')
	finish
endif
let b:ats_ftplugin = 1

" set config values
if !exists('g:ats_autoformat')
    if executable('atsfmt') == 1
        let g:ats_autoformat = 1
    else
        let g:ats_autoformat = 0
    endif
endif

" indentation rules
set smarttab
au BufNewFile,BufRead *.*ats
    \ set shiftwidth=2

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

" format on write
if g:ats_autoformat == 1
    augroup ats
            autocmd BufWritePost *.ats,*.dats,*.sats,*.cats call AtsFormat()
    augroup END
endif

" commands
command -nargs=0 Format call AtsFormat()
command -nargs=0 Check SyntasticCheck patscc
