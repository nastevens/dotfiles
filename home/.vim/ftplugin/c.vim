runtime coding-common.vim

augroup LinuxSourceException
    autocmd!
    autocmd BufEnter  *linux*/*.[ch]  setlocal tabstop=8 softtabstop=8 shiftwidth=8
    autocmd BufEnter  *linux*/*.[ch]  exec "setlocal lcs=tab:\uB7\uB7,trail:\uB7,nbsp:~"
    autocmd BufEnter  *linux*/*.[ch]  setlocal list
    autocmd BufEnter  *linux*/*.[ch]  setlocal noexpandtab
augroup END
