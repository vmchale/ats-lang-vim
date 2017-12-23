" Author: Vanessa McHale
" Maintainer: Vanessa McHale <vamchale@gmail.com>

if exists('b:ats_plugin')
	finish
endif
let b:ats_plugin = 1

augroup ats
    exec 'autocmd BufWritePost *.*ats Check'
    exec 'command! Check SyntasticCheck | Error'
augroup END
