# Enable colors for ls, etc.  Prefer ~/.dir_colors
if whence -p dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    else
        eval $(dircolors --print-database)
    fi
fi
