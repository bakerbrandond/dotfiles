#
# Point zsh at the real config under XDG. Keep this file minimal: it is the
# only zsh dotfile that lives in $HOME.
#
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
[[ -s "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
