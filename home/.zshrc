# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load. (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(colored-man-pages dircolors git history prune-paths)

# Paths to add to PATH
path=(
    # MacPorts paths
    "/opt/local/bin"
    "/opt/local/sbin"
    "/opt/local/libexec/gnubin"

    # Local binaries
    "$HOME/local/bin"
    "$HOME/.local/bin"
    "$HOME/.scripts"

    # Ruby gem binaries
    "$HOME/.gem/ruby/1.8/bin"
    "$HOME/.gem/ruby/1.9.1/bin"
    "$HOME/.gem/ruby/2.0.0/bin"

    # Android SDK binaries
    "$HOME/androidsdk/platform-tools"
    "$HOME/androidsdk/tools"

    # Microchip compiler binaries
    "$HOME/local/microchip/xc8/bin"
    "$HOME/local/microchip/xc16/bin"
    "$HOME/local/microchip/xc32/bin"

    # Cargo binaries
    "$HOME/.cargo/bin"

    # pyenv binaries
    "$HOME/.pyenv/bin"

    # Include system paths
    $path
)

# Use local libraries if available
if [ -d "$HOME/local/lib" ]; then
    export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
fi

# If Dropbox folder is in expected locations export env var
if [ -d "$HOME/Dropbox" ]; then
    export DROPBOX='~/Dropbox'
fi

# The only sane editor option
export EDITOR='vim'

# Use UTF-8
export LANG=en_US.UTF-8

# Enable pyenv, if it is installed
if whence -p pyenv >/dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Enable the OMZ sauce
source $ZSH/oh-my-zsh.sh
