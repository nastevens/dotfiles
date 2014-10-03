augroup LinuxSourceException
    autocmd!
    autocmd BufEnter  *linux*/*.[ch]  let b:TabsOkay=1
    autocmd BufEnter  *linux*/*.[ch]  let b:Tabs8=1
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

runtime coding-common.vim
