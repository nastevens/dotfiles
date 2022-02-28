alias bc="bc -l"
alias c="clear"
alias df="df -h"
alias grep="grep --colour=auto"
alias rustfmt-nightly="rustup run nightly rustfmt --config-path ~/.nightly-rustfmt.toml --emit files --edition 2018"
alias su="su -"
alias tmux="tmux -2"
alias vimupdate="nvim +PackerSync"
alias x="tar axf"

command -v nvim >/dev/null 2>&1 && alias vim="nvim"

if hash gping >/dev/null 2>&1; then
    alias ping=gping
fi
