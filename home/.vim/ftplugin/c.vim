function! LinuxSource()
    let b:TabsOkay=1
    let b:OverLength=80
    let b:TabsWidth=8
    runtime coding-common.vim
endfunction

function! WorkSource()
    unlet! b:TabsOkay
    let b:OverLength=80
    let b:TabsWidth=2
    runtime coding-common.vim
endfunction

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

nnoremap <buffer> K :Silent man -s 2,3,4,5,6,7,8,9,1 <C-R>=expand("<cword>")<CR><CR>

if expand('%:p') =~? '\v%(linux|u\-?boot|optee).{-}\/.*\.[ch]'
    call LinuxSource()
elseif expand('%:p') =~? '\vprojects\/.*\.%([ch]|cpp)'
    call WorkSource()
else
    runtime coding-common.vim
endif
