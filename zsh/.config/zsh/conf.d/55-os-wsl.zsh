#
# WSL only (sourced after 50-os-linux.zsh, so it wins where they overlap).
#

(( $+commands[clip.exe] ))   && alias clip='clip.exe'
(( $+commands[wslview] ))    && alias o='wslview'
(( $+commands[explorer.exe] )) && alias e='explorer.exe .'

# No desktop session here, so make sure nothing assumes an X display.
unalias dmen 2>/dev/null
unalias gquit 2>/dev/null
