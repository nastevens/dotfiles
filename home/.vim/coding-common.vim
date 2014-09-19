" Common settings for editing code

" Set tabs to 4 expanded spaces
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab

" Round shifts to increments of 4
setlocal shiftround
 
" Turn on line numbers
setlocal number

" Don't wrap automatically
setlocal nowrap
setlocal textwidth=0
setlocal formatoptions=cq
setlocal wrapmargin=0

" Highlight characters over 80 columns
highlight OverLength ctermfg=white ctermbg=darkgray guifg=white guibg=darkgrey
match OverLength /\%81v.\+/
