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
    colored-man-pages
    command-not-found
    history
    rupa/z
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
    radhermit/gentoo-zsh-completions
    lukechilds/zsh-nvm
EOBUNDLES
antigen theme "$ZSH/themes" nick
antigen apply

# Paths to add to PATH. I should be able to put these in .zshenv, but every
# distro seems intent on breaking this with their own settings that clobber
# PATH in the system-wide zprofile.
path=(
    # MacPorts paths
    "/opt/local/bin"
    "/opt/local/sbin"
    "/opt/local/libexec/gnubin"

    # Local binaries
    "$HOME/local/bin"
    "$HOME/local/usr/bin"
    "$HOME/.local/bin"
    "$HOME/.scripts"
    "$HOME/Library/python/2.7/bin"

    # Ruby gem binaries
    "$HOME/.gem/ruby/1.8/bin"
    "$HOME/.gem/ruby/1.9.1/bin"
    "$HOME/.gem/ruby/2.0.0/bin"
    "$HOME/.gem/ruby/2.1.0/bin"
    "$HOME/.gem/ruby/2.2.0/bin"
    "$HOME/.gem/ruby/2.3.0/bin"

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

# Enable pyenv, if it is installed
if whence -p pyenv >/dev/null; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
fi

# Options
setopt autocontinue
setopt correct
setopt notify
setopt noautopushd

# Source my "plugin" scripts
source "$ZSH/aliases.zsh"
source "$ZSH/dircolors.zsh"
source "$ZSH/homesick.zsh"

# Finally, clean up paths, removing duplicates and non-existant directories
source $HOME/.zsh/prune-paths.zsh
