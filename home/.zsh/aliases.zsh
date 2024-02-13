# Aliases that only use coreutils or other tools that would cause a broken
# system if they didn't exist.
alias c="clear"
alias df="df -h"
alias grep="grep --colour=auto"
alias rmf="rm -rf"
alias su="su -"

# Aliases for programs that may or may not exist.
function alias_if_exists() {
    if command -v $1 >/dev/null 2>&1; then
        alias "$2=$3"
    fi
}

alias_if_exists bandwhich bandwhich "sudo $HOME/.cargo/bin/bandwhich"
alias_if_exists bc bc "bc -l"
alias_if_exists garden ga garden
alias_if_exists gping ping gping
alias_if_exists exa l exa
alias_if_exists exa ll "exa -lh"
alias_if_exists exa la "exa -a"
alias_if_exists exa lla "exa -la"
alias_if_exists nvim vim nvim
alias_if_exists nvim vimupdate "nvim +PackerSync"
alias_if_exists rustup rustfmt-nightly "rustup run nightly rustfmt --config-path ~/.nightly-rustfmt.toml --emit files --edition 2021"
alias_if_exists smartthings st smartthings
alias_if_exists tmux tmux "tmux -2"
alias_if_exists xdg-open open xdg-open

# Colorize help output
alias_if_exists bat bathelp "bat --plain --language=help"
if command -v bat >/dev/null 2>&1; then
    function help() {
        "$@" --help 2>&1 | bathelp
    }
fi
