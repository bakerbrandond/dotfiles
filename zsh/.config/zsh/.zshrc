#
# Executes commands at the start of an interactive session.
#
# $ZDOTDIR is a stow symlink into the dotfiles repo, so nothing generated at
# runtime may be written there — plugin bundle, completion dumps and compiled
# files all go to $XDG_CACHE_HOME/zsh.
#

typeset -g _zcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $_zcache ]] || mkdir -p $_zcache

export ANTIDOTE_HOME="${ANTIDOTE_HOME:-$_zcache/antidote}"
export ZSH_COMPDUMP="$_zcache/omz-zcompdump-$ZSH_VERSION"   # oh-my-zsh's own

# A non-login interactive shell (a tmux pane) never runs .zprofile, so pull in
# the environment it would have set. zsh_conf_load keeps this to one load.
zsh_conf_load 10-path.zsh 20-brew.zsh

#
# Build the antidote bundle, if it is missing or stale.
#
# Deliberately above the instant-prompt block: on a new machine this clones
# every plugin, which takes seconds and writes progress to stderr. p10k
# requires that kind of initialization to sit above the block.
#
_antidote=$ZDOTDIR/plugins/antidote/antidote.zsh
_zbundle=$_zcache/zsh_plugins.zsh
if [[ -r $_antidote ]]; then
  _stale=( $_zbundle(N.) )
  if (( ! $#_stale )) || [[ $ZDOTDIR/.zsh_plugins.txt -nt $_zbundle ]]; then
    print -ru2 -- 'zsh: building plugin bundle (first run clones plugins)...'
    source $_antidote
    if ! antidote bundle <$ZDOTDIR/.zsh_plugins.txt >| $_zbundle; then
      command rm -f -- $_zbundle
      print -ru2 -- 'zsh: antidote bundle failed; continuing without plugins'
    fi
  fi
  unset _stale
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load the plugins. If the submodule is not checked out this is skipped and you
# get a plain, working shell rather than a broken one; the README says how to
# fix that (git submodule update --init).
[[ -r $_zbundle ]] && source $_zbundle
unset _antidote _zbundle

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ -r $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

#
# Everything else, in order. 50-os-* and 55-os-* are platform gated inside
# zsh_conf_load; completion runs last so fpath is final by then.
#
zsh_conf_load \
  00-options.zsh \
  30-aliases.zsh \
  40-tools.zsh \
  50-os-darwin.zsh \
  50-os-linux.zsh \
  55-os-wsl.zsh \
  90-completion.zsh

#
# Per-machine overrides. Untracked by design: secrets, one-off PATH entries,
# and anything that is true of exactly one of these machines.
#
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
