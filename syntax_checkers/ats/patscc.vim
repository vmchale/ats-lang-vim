if exists('g:loaded_syntastic_ats_patscc_checker')
    finish
endif
let g:loaded_syntastic_ats_patscc_checker = 1

let g:syntastic_ats_patscc_exec = 'patscc'

function! Cleanup(errors) abort " {{{2
   
    exec 'silent !rm -f a.out'

    return a:errors

endfunction " }}}2

function! SyntaxCheckers_ats_patscc_GetLocList() dict
    let makeprg = self.makeprgBuild({
                \ 'exe': self.getExec(),
                \ 'args': '-DATS_MEMALLOC_LIBC -cleanaft',
                \ 'fname': shellescape(expand('%') )})

    let errorformat =
        \ 'exit(ATS):%m,' .
        \ '%f:%m'

    let loclist = SyntasticMake({ 
            \ 'makeprg': makeprg,
            \ 'errorformat': errorformat })

    return loclist

endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'ats',
    \ 'name': 'patscc',
    \ 'postprocess': 'Cleanup'})
