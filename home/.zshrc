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
EOBUNDLES
antigen theme "$ZSH/themes" nick
antigen apply

# Enable pyenv, if it is installed
if whence -p pyenv >/dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Source my "plugin" scripts
source "$ZSH/aliases.zsh"
source "$ZSH/dircolors.zsh"

# Options
setopt autocontinue
setopt correct
setopt notify

# Finally, clean up paths, removing duplicates and non-existant directories
source $HOME/.zsh/prune-paths.zsh
