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
Plug 'andymass/vim-matchup'
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
Plug 'ctrlpvim/ctrlp.vim' "{{{
  let g:ctrlp_extensions = ['tag', 'mixed']
  let g:ctrlp_cmd = 'CtrlPTag'
  if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
  elseif executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co', 'find %s -type f']
  endif
  nnoremap <C-f> :CtrlP<CR>
"}}}
Plug 'corntrace/bufexplorer' "{{{
  let g:bufExplorerShowRelativePath=1
"}}}
Plug 'mbbill/undotree' "{{{
  nnoremap <leader>u :UndotreeToggle<CR>
"}}}
Plug 'mileszs/ack.vim' "{{{
  if executable('rg')
    let g:ackprg = 'rg --vimgrep'
  elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
  cabbrev Rg LAck
  cabbrev Ag LAck
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
  let wiki_base = {
    \ 'template_path': g:personal_dropbox_loc . '/vimwiki-html/assets/',
    \ 'template_default': 'default',
    \ 'template_ext': '.tpl',
    \ 'auto_export': 0,
    \ 'nested_syntaxes': {
      \ 'bash': 'bash',
      \ 'c++': 'cpp',
      \ 'ebnf': 'ebnf',
      \ 'groovy': 'groovy',
      \ 'markdown': 'markdown',
      \ 'python': 'python',
      \ 'rust': 'rust',
      \ 'sh': 'sh',
      \ 'verilog': 'verilog',
      \ 'xml': 'xml',
      \ 'zsh': 'zsh',
    \ },
  \ }
  let wiki_personal = copy(wiki_base)
  let wiki_personal.path = g:personal_dropbox_loc . '/vimwiki/'
  let wiki_personal.path_html = g:personal_dropbox_loc . '/vimwiki-html/'
  let wiki_work = copy(wiki_base)
  let wiki_work.path = g:personal_dropbox_loc . '/smartthings/vimwiki/'
  let wiki_work.path_html = g:personal_dropbox_loc . '/smartthings/vimwiki-html/'
  let g:vimwiki_list = [wiki_personal, wiki_work]
  let g:vimwiki_folding = 'expr'
  nnoremap <leader>wp :norm 1\ww<CR>
  nnoremap <leader>wo :norm 2\ww<CR>
  nnoremap <leader>wo\i :norm 2\wi<CR>
  nnoremap <leader>sc :exec "edit " . g:personal_dropbox_loc . "/scratchpad.wiki"<CR>
"}}}

" =====[Syntax/Indenting]=====
Plug 'godlygeek/tabular'
Plug 'kergoth/vim-bitbake'
Plug 'hashivim/vim-terraform'
Plug 'nastevens/vim-duckscript'
Plug 'nastevens/vim-cargo-make'
Plug 'ngg/vim-gn'
Plug 'rust-lang/rust.vim' "{{{
  let g:rustfmt_command = "rustfmt +nightly"
"}}}
Plug 'sheerun/vim-polyglot' "{{{
  " The rust plugin is intentionally limited in polyglot, we want the whole thing
  let g:polyglot_disabled = [
    \ 'rust',
  \]
"}}}
Plug 'sirtaj/vim-openscad'
Plug 'tfnico/vim-gradle'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-scripts/ebnf.vim'
Plug 'vim-scripts/scons.vim' "{{{
  au BufNewFile,BufRead SCons* set filetype=scons
"}}}

" =====[Rust-Specific]=====
if executable("rusty-tags")
  augroup RustyTags
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
  augroup END
endif

" =====[Code Completion/Linting]=====
if g:os != "Windows"
  Plug 'valloric/YouCompleteMe', { 'do': './install.py --rust-completer' } "{{{
    " Workaround for https://github.com/Valloric/YouCompleteMe/issues/3062
    silent! py3 pass
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  "}}}
  Plug 'w0rp/ale' "{{{
    let g:ale_rust_cargo_check_tests = 1
    let g:ale_rust_cargo_check_examples = 1
    let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_open_list = 1
  "}}}
endif

" =====[Coding]=====
if v:version >= 704
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' "{{{
      let g:UltiSnipsExpandTrigger="<tab>"
    "}}}
endif
Plug 'dantler/vim-alternate'
Plug 'ludovicchabant/vim-gutentags', { 'for': [ 'c', 'cpp', 'python', 'sh' ] }
Plug 'mhinz/vim-signify' "{{{
  let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
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
Plug 'nastevens/stvimhelper', { 'do': 'pipx install --force .', 'for': 'vimwiki' }

" =====[Theming]=====
Plug 'ajh17/Spacegray.vim'
