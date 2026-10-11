#
# Linux only (sourced by zsh_conf_load when $OSTYPE is linux*).
#

# Clipboard: Wayland, then X11. WSL overrides this in 55-os-wsl.zsh.
if (( $+commands[wl-copy] )); then
  alias clip='wl-copy'
elif (( $+commands[xclip] )); then
  alias clip='xclip -selection clipboard'
elif (( $+commands[xsel] )); then
  alias clip='xsel --clipboard --input'
fi

(( $+commands[xdg-open] )) && alias o='xdg-open'

[[ -n "$HOMEBREW_PREFIX" && -d $HOMEBREW_PREFIX/opt/libpq/bin ]] &&
  path=($HOMEBREW_PREFIX/opt/libpq/bin $path)

#
# Desktop-session-only helpers. Skipped on a headless box and under WSL.
#
if [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
  (( $+commands[gnome-session-quit] )) && alias gquit='gnome-session-quit'
  (( $+commands[dmenu_run] )) && alias dmen='dmenu_run'
fi
