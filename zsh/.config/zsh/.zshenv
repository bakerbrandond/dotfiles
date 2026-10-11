#
# Defines environment variables for every zsh invocation, including scripts
# and `ssh host cmd`. Keep this cheap and tool-independent: anything that
# needs a binary to exist belongs in conf.d/, which only login and
# interactive shells read.
#

# Ubuntu's /etc/zsh/zshrc runs its own compinit (see /etc/zsh/zshrc:110-112)
# before our .zshrc, so this has to be set here, not in conf.d. Completion is
# initialized once, in conf.d/90-completion.zsh.
skip_global_compinit=1

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Ensure path-like arrays never collect duplicates, however many times the
# conf.d files below get re-entered.
typeset -gU cdpath fpath mailpath path

#
# conf.d loader
#
# Both .zprofile and .zshrc pull in conf.d files; this keeps each one to a
# single load per shell, so a non-login interactive shell (a tmux pane) gets
# the same environment as a login shell without paying for it twice. Files
# named 50-os-* and 55-os-* are platform gated.
#
typeset -gA _ZSH_CONF_LOADED

zsh_conf_load() {
  local name file
  for name in "$@"; do
    file="$ZDOTDIR/conf.d/$name"
    [[ -r $file ]] || continue
    [[ -n ${_ZSH_CONF_LOADED[$name]} ]] && continue
    case $name in
      50-os-darwin.zsh) [[ $OSTYPE == darwin* ]] || continue ;;
      50-os-linux.zsh)  [[ $OSTYPE == linux*  ]] || continue ;;
      55-os-wsl.zsh)
        [[ $OSTYPE == linux* ]] || continue
        [[ -n $WSL_DISTRO_NAME || -r /proc/sys/fs/binfmt_misc/WSLInterop ]] || continue
        ;;
    esac
    _ZSH_CONF_LOADED[$name]=1
    source $file
  done
}
