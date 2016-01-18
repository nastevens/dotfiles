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
export path

# The only sane editor option
export EDITOR='vim'

# Use UTF-8
export LANG=en_US.UTF-8

# Use local libraries if available
[[ -d "$HOME/local/lib" ]] && export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

# If Dropbox folder is in expected locations export env var
[[ -d "$HOME/Dropbox" ]] && export DROPBOX='~/Dropbox'
