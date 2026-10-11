#
# Shell options, history, keybindings.
#

setopt hist_ignore_all_dups     # drop older duplicates of a repeated command
setopt hist_ignore_space        # keep commands starting with a space out of history
setopt share_history            # share history between concurrent shells
setopt extended_history         # record timestamps
setopt hist_verify              # expand a !! into the line instead of running it
setopt interactive_comments     # allow # comments at an interactive prompt
setopt auto_cd                  # `cd` by typing a directory name
setopt no_beep

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

# Carry over the old ~/.zsh_history the first time this runs.
if [[ ! -s $HISTFILE && -s $HOME/.zsh_history ]]; then
  cat $HOME/.zsh_history >| $HISTFILE
fi

bindkey -e                      # emacs keybindings even when EDITOR is vi
