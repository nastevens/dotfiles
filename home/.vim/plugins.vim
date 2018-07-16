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
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-expand-region' "{{{
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
"}}}
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

" =====[Tools and UIs]=====
Plug 'vim-airline/vim-airline' "{{{
  let g:airline_powerline_fonts = 1
"}}}
Plug 'vim-airline/vim-airline-themes' "{{{
  let g:airline_theme='jellybeans'
"}}}
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
Plug 'mbbill/undotree' "{{{
  nnoremap <leader>u :UndotreeToggle<CR>
"}}}
Plug 'reedes/vim-litecorrect' "{{{
  augroup litecorrect
    autocmd!
    autocmd FileType gitcommit call litecorrect#init()
    autocmd FileType markdown call litecorrect#init()
    autocmd FileType textile call litecorrect#init()
    autocmd FileType vimwiki call litecorrect#init()
  augroup END
  let g:litecorrect#typographic = 0
"}}}
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "{{{
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
"}}}

" =====[Syntax/Indenting]=====
Plug 'kergoth/vim-bitbake'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot' "{{{
  " In favor of full rust.vim
  let g:polyglot_disabled = ['rust']
"}}}
Plug 'tfnico/vim-gradle'
Plug 'tmux-plugins/vim-tmux'
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

" =====[Code Completion/Linting]=====
if g:os != "Windows"
  Plug 'valloric/YouCompleteMe', { 'do': './install.py --rust-completer' } "{{{
    " Workaround for https://github.com/Valloric/YouCompleteMe/issues/3062
    silent! py3 pass
  "}}}
  Plug 'w0rp/ale'
endif

" =====[Coding]=====
if v:version >= 704
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' "{{{
      let g:UltiSnipsExpandTrigger="<tab>"
    "}}}
endif
Plug 'dantler/vim-alternate'
Plug 'ludovicchabant/vim-gutentags', { 'for': 'c' }
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
  autocmd BufReadPost fugitive://* set bufhidden=wipe
"}}}

" =====[Other]=====
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/bufkill.vim' "{{{
  " Replace normal buffer unload/delete/wipe mappings with bufkill.vim
  cabbrev bun BUN
  cabbrev bd BD
  cabbrev bw BW
"}}}

" =====[Theming]=====
Plug 'ajh17/Spacegray.vim'
