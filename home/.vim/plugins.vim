" vim: set fenc=utf-8 tw=78 sw=2 sts=2 et fdl=0 fdm=marker:

" Some plugins don't play nice with Windows
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

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
Plug 'vim-airline/vim-airline' "{{{
  let g:airline_powerline_fonts = 1
"}}}
Plug 'vim-airline/vim-airline-themes' "{{{
  let g:airline_theme='jellybeans'
"}}}
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim' "{{{
  let g:ctrlp_extensions = ['tag', 'mixed']
  let g:ctrlp_cmd = 'CtrlPTag'
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co', 'find %s -type f']
  endif
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
  let NERDTreeIgnore=[
    \ '\.pyc$[[file]]',
    \ '\~$',
    \ '^__pycache__$[[dir]]',
    \ '^tags$[[file]]',
    \ '^.*\.egg$[[dir]]',
    \ '^.*\.egg-info$[[dir]]',
    \ '\.o$[[file]]',
    \ '\.su$[[file]]',
    \ ]
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
        \ 'bash': 'bash',
        \ 'c++': 'cpp',
        \ 'ebnf': 'ebnf',
        \ 'groovy': 'groovy',
        \ 'java': 'java',
        \ 'markdown': 'markdown',
        \ 'python': 'python',
        \ 'rust': 'rust',
        \ 'sh': 'sh',
        \ 'verilog': 'verilog',
        \ 'xml': 'xml',
        \ 'zsh': 'zsh',
        \ }
  let g:vimwiki_list = [wiki_1]
  let g:vimwiki_folding = 'expr'

  nnoremap <leader>wo :VimwikiIndex<CR> :VimwikiGoto work/index<CR>
  nnoremap <leader>d :VimwikiIndex<CR> :VimwikiGoto Brain Dump<CR>
  nnoremap <leader>wod :VimwikiIndex<CR> :VimwikiGoto work/Brain Dump<CR>
"}}}

" =====[Syntax/Indenting]=====
Plug 'kergoth/vim-bitbake'
Plug 'sheerun/vim-polyglot'
Plug 'tfnico/vim-gradle'
Plug 'vim-scripts/ebnf.vim'
Plug 'vim-scripts/scons.vim' "{{{
  au BufNewFile,BufRead SCons* set filetype=scons
"}}}

" =====[Rust-Specific]=====
let g:rust_src_path = ""
if g:os == "Darwin"
  let g:rust_src_path = $HOME . '/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
endif
if g:os == "Linux"
  let g:rust_src_path = $HOME . '/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
endif

if executable("rusty-tags")
  augroup RustyTags
    autocmd BufRead *.rs :silent! exec "setlocal tags=./rusty-tags.vi;/," . g:rust_src_path . "/rusty-tags.vi"
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
  augroup END
endif

" =====[Code Completion]=====
if g:os != "Windows"
  Plug 'Shougo/deoplete.nvim' "{{{
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    let g:deoplete#enable_at_startup = 1
  "}}}
  " Requires compile of libclang
  " Plug 'zchee/deoplete-clang'
  Plug 'Shougo/neco-syntax'
  Plug 'Shougo/neco-vim'
  Plug 'zchee/deoplete-jedi'
  Plug 'zchee/deoplete-zsh'
  Plug 'sebastianmarkow/deoplete-rust' "{{{

    let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
    if g:os == "Darwin"
      let g:deoplete#sources#rust#rust_source_path = $HOME . '/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
    endif
    if g:os == "Linux"
      let g:deoplete#sources#rust#rust_source_path = $HOME . '/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
    endif
  "}}}
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ } "{{{
    let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ }
    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  "}}}
endif

" =====[Code Linting/Style]=====
Plug 'scrooloose/syntastic' "{{{
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_python_flake8_post_args = '--ignore=E501'
"}}}

" =====[Coding]=====
if v:version >= 704
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' "{{{
      let g:UltiSnipsExpandTrigger="<tab>"
    "}}}
endif
Plug 'dantler/vim-alternate'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-signify' "{{{
  let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
"}}}
Plug 'majutsushi/tagbar' "{{{
  nnoremap <leader>t :TagbarToggle<CR>
  let g:tagbar_type_rust = {
      \ 'ctagstype' : 'rust',
      \ 'kinds' : [
          \'T:types,type definitions',
          \'f:functions,function definitions',
          \'g:enum,enumeration names',
          \'s:structure names',
          \'m:modules,module names',
          \'c:consts,static constants',
          \'t:traits,traits',
          \'i:impls,trait implementations',
      \]
      \}
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
Plug 'jreybert/vimagit'

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
