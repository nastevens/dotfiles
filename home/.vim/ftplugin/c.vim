augroup LinuxSourceException
    autocmd!
    autocmd BufEnter  *linux*/*.[ch]  let b:TabsOkay=1
    autocmd BufEnter  *linux*/*.[ch]  let b:Tabs8=1
    autocmd BufEnter  *linux*/*.[ch]  runtime coding-common.vim
    autocmd BufEnter  *u-boot*/*.[ch]  let b:TabsOkay=1
    autocmd BufEnter  *u-boot*/*.[ch]  let b:Tabs8=1
    autocmd BufEnter  *u-boot*/*.[ch]  runtime coding-common.vim
augroup END

function! GlennSource()
    if exists('b:GlennSourceToggle')
        unlet b:GlennSourceToggle
        unlet b:TabsOkay
        unlet b:OverLength
    else
        let b:GlennSourceToggle=1
        let b:TabsOkay=1
        let b:OverLength=120
    endif
    runtime coding-common.vim
endfunction

if exists('b:GlennSourceToggle')
    let b:TabsOkay=1
    let b:Overlength=120
endif

nnoremap <LocalLeader>gs :call GlennSource()<CR>

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

nnoremap K :Silent man -s 2,3,4,5,6,7,8,9,1 <C-R>=expand("<cword>")<CR><CR>

runtime coding-common.vim
