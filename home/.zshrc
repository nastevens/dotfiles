# Uncomment this and zprof at the end to profile startup
# zmodload zsh/zprof

# Directory for my customizations
ZSH=$HOME/.zsh
ADOTDIR=$HOME/.antigen

# Download and install antigen if it doesn't exist
if [ ! -f "$ADOTDIR/antigen/antigen.zsh" ]; then
    echo "zsh antigen not installed - cloning..."
    mkdir -p "$ADOTDIR"
    git clone https://github.com/zsh-users/antigen "$ADOTDIR/antigen"
fi

# Install antigen plugins
source "$ADOTDIR/antigen/antigen.zsh"
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
    # oh-my-zsh plugins
    colored-man-pages
    docker
    history
    ripgrep
    rust
    terraform

    # github plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
EOBUNDLES

if [ ! -f "$ZSH/disable_ssh_agent" ]; then
    antigen bundle ssh-agent
fi

# Lazy-load nvm
export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

antigen apply
source "$ZSH/themes/nick.zsh-theme"

# Paths to add to PATH. I should be able to put these in .zshenv, but every
# distro seems intent on breaking this with their own settings that clobber
# PATH in the system-wide zprofile. So instead every possibility is added and
# the ones that don't exist are pruned later.
path=(
    # Local binaries
    "$HOME/.local/bin"
    "$HOME/.scripts"

    # Homebrew binaries
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/local/opt/curl/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/local/opt/gnu-sed/libexec/gnubin"

    # Cargo binaries
    "$HOME/.cargo/bin"

    # pyenv binaries
    "$HOME/.pyenv/bin"

    # Ruby
    "$HOME/.rvm/bin"

    # Include system paths
    $path
)
export path

# Golang GOPATH
export GOPATH="$HOME/.golang"

# Add local man pages
export MANPATH="$MANPATH:$HOME/.local/share/man"

# The only sane editor option
command -v nvim >/dev/null 2>&1 && \
    export EDITOR='nvim' || \
    export EDITOR='vim'

# Use UTF-8
export LANG=en_US.UTF-8

# Some utilities expect these values to be set and don't use defaults (looking
# at you fontconfig).
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}

# If Dropbox folder is in expected locations export env var
[[ -e "$HOME/Dropbox" ]] && export DROPBOX='~/Dropbox'

# Source local tokens/keys if present
[[ -f "$HOME/.zsh/tokens.zsh" ]] && source "$HOME/.zsh/tokens.zsh"

# Enable chtf if it is installed
if [[ -f "/usr/local/share/chtf/chtf.sh" ]]; then
    source "/usr/local/share/chtf/chtf.sh"
fi

# Enable pyenv if it is installed
if command -v pyenv &> /dev/null; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
fi

# Enable rvm if it is installed
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

# Options
setopt autocontinue
setopt correct
setopt notify
setopt noautopushd

# Enable SSH agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Source my "plugin" scripts
source "$ZSH/aliases.zsh"
source "$ZSH/dircolors.zsh"
source "$ZSH/homesick.zsh"
source "$ZSH/mancolor.zsh"

# Clean up paths, removing duplicates and non-existant directories
source "$ZSH/prune-paths.zsh"

# Fix https://github.com/robbyrussell/oh-my-zsh/issues/1398
zstyle ':completion:*' matcher-list 'r:|=*' '+ r:|[._-]=* l:|=*'

# Add custom completion functions
fpath+=~/.zfunc

# Uncomment with first line to profile startup
# zprof
