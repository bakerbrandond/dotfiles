#
# WSL only (sourced after 50-os-linux.zsh, so it wins where they overlap).
#

# The Windows GPU driver maps its Linux-side tools in here -- nvidia-smi among
# them, so there is nothing to install. WSL normally appends this to PATH
# itself, but that injection is tied to Windows interop, which is off on this
# box, so add it explicitly.
[[ -d /usr/lib/wsl/lib ]] && path+=(/usr/lib/wsl/lib)

(( $+commands[clip.exe] ))   && alias clip='clip.exe'
(( $+commands[wslview] ))    && alias o='wslview'
(( $+commands[explorer.exe] )) && alias e='explorer.exe .'

# No desktop session here, so make sure nothing assumes an X display.
unalias dmen 2>/dev/null
unalias gquit 2>/dev/null

export OPENSCAD_ENGINE=/home/bbd/repos/openscad-cli/build/engine/openscad
