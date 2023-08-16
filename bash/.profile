# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes npm global installs
PATH=/usr/local/lib/node_modules:$PATH
#if [ -d $(npm root -g) ] ; then
    #PATH="$(npm root -g):$PATH"
#fi

#
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#PATH=$(go env GOPATH)/bin:$PATH
# Install Ruby Gems to ~/gems
#export GEM_HOME="$HOME/gems"
#export PATH="$HOME/gems/bin:$PATH"

# needed for gpg2
# TODO seems to break when login from desktop
#      current M.O ssh
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME=$HOME/.config

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1

. "$HOME/.cargo/env"
