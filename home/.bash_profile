#!/bin/bash

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds colon separated items to "var" if they exist. If multiples items are
# specified, they will be added in the order provided.
add_if_exists() {
    local var_name=$1
    shift
    for (( i = ${#@}; i > 0; i-- ))
    {
        local item=`echo ${!i}`
        if [ -d ${item} ]; then
            if [ -z "${!var_name}" ]; then
                export "${var_name}=${item}"
            else
                export "${var_name}=${item}:${!var_name}"
            fi
        fi
    }
}

# MacPorts paths
add_if_exists PATH \
    "/opt/local/bin" \
    "/opt/local/sbin" \
    "/opt/local/libexec/gnubin"

# Local binaries
add_if_exists PATH \
    "$HOME/local/bin" \
    "$HOME/.scripts"
add_if_exists LD_LIBRARY_PATH \
    "$HOME/local/lib"

# Ruby gem binaries
add_if_exists PATH \
    "$HOME/.gem/ruby/1.8/bin" \
    "$HOME/.gem/ruby/2.0.0/bin"

# Android SDK binaries
add_if_exists PATH \
    "$HOME/androidsdk/platform-tools" \
    "$HOME/androidsdk/tools"

unset add_if_exists

# Enable bash-completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
