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
# Guarded so re-entry does not stack duplicates; this file sources .bashrc,
# which prepends some of the same entries.
case ":$PATH:" in
    *":$HOME/bin:"*) ;;
    *) [ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH" ;;
esac

# set PATH so it includes user's private bin if it exists
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH" ;;
esac

# set PATH so it includes npm global installs
PATH=/usr/local/lib/node_modules:$PATH
PATH=/opt/android-studio/bin:$PATH
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

# No GDK_SCALE here on purpose. It only takes integers, so this ~171 DPI
# panel got rounded up to 2x -- a 960x600 logical screen that fixed-size
# windows overflowed. Fractional scaling comes from Xft.dpi in .Xresources
# instead; this lets Qt read it too.
export QT_AUTO_SCREEN_SCALE_FACTOR=1

[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export ANDROID_HOME="/home/bbd/Android/Sdk"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
