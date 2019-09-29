" Common settings for editing code

" Control if tabs stay tabs or convert to spaces
if exists('b:TabsOkay')
    exec "setlocal listchars=tab:\uA0\uA0,trail:\uB7,nbsp:~"
    setlocal noexpandtab
else
    exec "setlocal listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    setlocal expandtab
endif

" Control 4 or 8 space tabs
if exists('b:Tabs8')
    setlocal tabstop=8
    setlocal softtabstop=8
    setlocal shiftwidth=8
else
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
endif

" Match and highlight overlength lines
highlight OverLength ctermfg=white ctermbg=darkgray guifg=white guibg=darkgrey
if exists('b:OverLength')
    execute 'match OverLength /\%' . b:OverLength . 'v.\+/'
else
    match OverLength /\%80v.\+/
    nnoremap <leader>l :match OverLength /\%80v.\+/<CR>
    nnoremap <leader>ll :match OverLength /\%120v.\+/<CR>
    nnoremap <leader>lll :match OverLength /\%200v.\+/<CR>
    nnoremap <leader>lo :match none<CR>
endif

" Always use smart tabs
setlocal smarttab

" Round shifts to increments shiftwidth
setlocal shiftround

" Turn on relative line numbers
setlocal relativenumber

" Don't wrap automatically
setlocal nowrap
setlocal textwidth=0
setlocal formatoptions=cq
setlocal wrapmargin=0

" Align new lines inside arguments with first argument
setlocal cinoptions+=(0

" Enable indent markers
let b:indentLine_enable = 1

" Pretty-format JSON
command! PrettyJSON :%!python3 -c "import json, sys; print(json.dumps(json.load(sys.stdin), indent=4, sort_keys=True))"

" Pretty-format XML
command! PrettyXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
