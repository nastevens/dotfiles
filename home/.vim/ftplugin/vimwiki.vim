" Set tabs to 4 expanded spaces
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

" Turn on relative line numbers
setlocal relativenumber

" Disable soft wrapping
setlocal nowrap

" Disable hard wrapping
setlocal formatoptions-=t

" Disable long-line highlighting
match none

" Don't automatically fold
setlocal foldlevel=99

" Insert timestamps/interruption prompts
iabbrev <expr> dd strftime("%Y-%m-%d")
iabbrev <expr> tt strftime("%H:%M:%S")
iabbrev <expr> ts strftime("%Y-%m-%d %H:%M:%S")
iabbrev <expr> int strftime("%H:%M:%S INT")
