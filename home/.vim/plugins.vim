" vim: set fenc=utf-8 tw=78 sw=2 sts=2 et fdl=0 fdm=marker:

" =====[Sensible defaults]=====
Plug 'tpope/vim-sensible'

" =====[Movements, text objects]=====
Plug 'Lokaltog/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-expand-region' "{{{
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
"}}}
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/matchit.zip'
Plug 'wellle/targets.vim'

" =====[Tools and UIs]=====
Plug 'bling/vim-airline' "{{{
  let g:airline_theme='dark'
  let g:airline_left_sep=''
  let g:airline_right_sep=''
"}}}
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim' "{{{
  let g:ctrlp_extensions = ['tag', 'mixed']
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v(\.git|\.hg|\.svn|target|build|crossbuild)',
    \ 'file': '\v(tags$|\.exe$|\.so$|\.dll$)',
    \ }
  let g:ctrlp_cmd = 'CtrlPTag'
  nnoremap <C-f> :CtrlP<CR>
"}}}
Plug 'corntrace/bufexplorer'
Plug 'godlygeek/tabular'
Plug 'mbbill/undotree' "{{{
  nnoremap <leader>u :UndotreeToggle<CR>
"}}}
Plug 'reedes/vim-litecorrect' "{{{
  augroup litecorrect
    autocmd!
    autocmd FileType markdown call litecorrect#init()
    autocmd FileType textile call litecorrect#init()
    autocmd FileType gitcommit call litecorrect#init()
  augroup END
  let g:litecorrect#typographic = 0
"}}}
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree' "{{{
  let NERDTreeChristmasTree=1
  let NERDTreeCascadeOpenSingleChildDir=1
  let NERDTreeAutoDeleteBuffer=1
  let NERDTreeIgnore=['\.pyc$', '\~$', '^__pycache__$', '^tags$']
  nnoremap <leader>n :NERDTree<CR>
"}}}
Plug 'vim-scripts/visSum.vim'
Plug 'vimwiki/vimwiki' "{{{
  if isdirectory($HOME . "/Dropbox")
    let g:personal_dropbox_loc = $HOME . "/Dropbox"
  else
    let g:personal_dropbox_loc = $DROPBOX
  endif
  let wiki_1 = {}
  let wiki_1.path = g:personal_dropbox_loc . '/vimwiki/'
  let wiki_1.path_html = g:personal_dropbox_loc . '/vimwiki_html/'
  let wiki_1.template_path = g:personal_dropbox_loc . '/vimwiki_html/assets/'
  let wiki_1.template_default = 'default'
  let wiki_1.template_ext = '.tpl'
  let wiki_1.auto_export = 0
  let wiki_1.nested_syntaxes = {
        \ 'c++': 'cpp',
        \ 'ebnf': 'ebnf',
        \ 'groovy': 'groovy',
        \ 'java': 'java',
        \ 'markdown': 'markdown',
        \ 'python': 'python',
        \ 'rust': 'rust',
        \ 'sh': 'sh',
        \ 'verilog': 'verilog',
        \ }
  let g:vimwiki_list = [wiki_1]

  nnoremap <leader>wo :VimwikiIndex<CR> :VimwikiGoto work/index<CR>
  nnoremap <leader>d :VimwikiIndex<CR> :VimwikiGoto Brain Dump<CR>
  nnoremap <leader>wod :VimwikiIndex<CR> :VimwikiGoto work/Brain Dump<CR>
"}}}

" =====[Syntax/Indenting]=====
Plug 'cespare/vim-toml'
Plug 'dagwieers/asciidoc-vim'
Plug 'hdima/python-syntax' "{{{
  let python_highlight_all = 1
"}}}
Plug 'kergoth/vim-bitbake'
Plug 'sheerun/vim-polyglot'
Plug 'tfnico/vim-gradle'
Plug 'vim-scripts/ebnf.vim'
Plug 'vim-scripts/groovyindent'
Plug 'vim-scripts/indentpython.vim'

" =====[Coding]=====
" UltiSnips needs Vim >= 7.4 {{{
if v:version >= 704
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<tab>"
endif "}}}
Plug 'dantler/vim-alternate'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify' "{{{
  let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
"}}}
Plug 'majutsushi/tagbar' "{{{
  nnoremap <leader>t :TagbarToggle<CR>
"}}}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' "{{{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
  autocmd BufReadPost fugitive://* set bufhidden=delete
"}}}

" =====[Other]=====
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/bufkill.vim' "{{{
  " Replace normal buffer unload/delete/wipe mappings with bufkill.vim
  cabbrev bun BUN
  cabbrev bd BD
  cabbrev bw BW
"}}}

" =====[Theming]=====
Plug 'ajh17/Spacegray.vim'
