if exists('b:ats_ftplugin')
	finish
endif
let b:ats_ftplugin = 1

if !exists('g:ats_autoformat')
    let g:ats_autoformat = 0
endif

set smarttab
au BufNewFile,BufRead *.*ats
    \ set shiftwidth=2

setlocal commentstring=(*\ %s\ *)

function! AtsFormat()
    let cursor = getpos('.')
    exec 'normal! gg'
    exec 'silent !atsfmt -i ' . expand('%')
    exec 'e'
    call setpos('.', cursor)
endfunction

if g:ats_autoformat == 1
    augroup ats
            autocmd BufWritePost *.ats,*.dats,*.sats,*.cats call AtsFormat()
    augroup END
endif

command -nargs=0 Format call AtsFormat()
