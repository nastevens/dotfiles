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
    cargo
    colored-man-pages
    docker
    history
    ripgrep
    rust
    ssh-agent
    terraform

    # github plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
EOBUNDLES

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
    "$HOME/local/bin"
    "$HOME/local/usr/bin"
    "$HOME/.local/bin"
    "$HOME/.scripts"
    "$HOME/Library/python/2.7/bin"

    # Ruby
    "$HOME/.rvm/bin"
    "$HOME/.gem/ruby/2.7.0/bin"
    "$HOME/.gem/ruby/2.6.0/bin"
    "$HOME/.gem/ruby/2.5.0/bin"
    "$HOME/.gem/ruby/2.4.0/bin"
    "$HOME/.gem/ruby/2.3.0/bin"

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

    # Include system paths
    $path
)
export path

# The only sane editor option
export EDITOR='vim'

# Use UTF-8
export LANG=en_US.UTF-8

# Use local libraries if available
[[ -d "$HOME/local/lib" ]] && export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

# If Dropbox folder is in expected locations export env var
[[ -d "$HOME/Dropbox" ]] && export DROPBOX='~/Dropbox'

# Source local tokens/keys if present
[[ -f "$HOME/.zsh/tokens.zsh" ]] && source "$HOME/.zsh/tokens.zsh"

# Load pyenv if available
if command -v pyenv &> /dev/null; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
fi

# Enable rvm if it is installed
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

# Enable chtf if it is installed
if [[ -f "/usr/local/share/chtf/chtf.sh" ]]; then
    source "/usr/local/share/chtf/chtf.sh"
fi

# Point Racer at the Rust src distribution
command -v rustc >/dev/null 2>&1 && \
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust"

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

# Clean up paths, removing duplicates and non-existant directories
source "$ZSH/prune-paths.zsh"

# Fix https://github.com/robbyrussell/oh-my-zsh/issues/1398
zstyle ':completion:*' matcher-list 'r:|=*' '+ r:|[._-]=* l:|=*'

# Add custom completion functions
fpath+=~/.zfunc

# Teleport login name
export TELEPORT_LOGIN=ubuntu

# Uncomment with first line to profile startup
# zprof
