#
# Completion. Runs last, so fpath is final.
#
# oh-my-zsh (loaded as an antidote plugin) runs its own compinit; setting
# skip_global_compinit and running compinit once here keeps it to a single
# pass instead of the two the old config did.
#
autoload -Uz compinit bashcompinit

_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
[[ -d ${_zcompdump:h} ]] || mkdir -p ${_zcompdump:h}

# Rescan fpath at most once a day; trust the dump otherwise. The test has to be
# in array context — [[ ]] does not expand glob qualifiers, so the familiar
# [[ -n $dump(#qN.mh-24) ]] form is always true and never actually checks.
_zfresh=( $_zcompdump(N.mh-24) )
if (( $#_zfresh )); then
  compinit -C -d $_zcompdump          # trust the dump, skip the fpath scan
else
  compinit -i -d $_zcompdump          # -i: skip insecure directories silently
  touch $_zcompdump                   # compinit -C keys off mtime
fi
unset _zfresh
bashcompinit

# Compile the dump in the background — zsh loads a .zwc much faster.
if [[ -s $_zcompdump && (! -s ${_zcompdump}.zwc || $_zcompdump -nt ${_zcompdump}.zwc) ]]; then
  { zcompile -R -- ${_zcompdump}.zwc $_zcompdump } &!
fi
unset _zcompdump

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
