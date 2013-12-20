# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# MacPorts paths
export PATH=/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin/:$PATH

# Local binaries
export PATH=~/local/bin:$PATH

# Ruby gem binaries
export PATH=~/.gem/ruby/1.8/bin:~/.gem/ruby/2.0.0/bin:$PATH
