#
# Optional tool integrations. Every one is guarded: a missing tool means the
# feature is off, not an error on startup.
#

#
# asdf
#
# asdf 0.16 dropped libexec/asdf.sh entirely (the Go rewrite); shims on PATH
# plus the completions directory is the current form.
#
if (( $+commands[asdf] )); then
  export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
  path=($ASDF_DATA_DIR/shims(N) $path)
  fpath=($ASDF_DATA_DIR/completions(N) $fpath)
fi

#
# Version managers and language toolchains
#
if [[ -s $HOME/.nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  source $NVM_DIR/nvm.sh
  [[ -s $NVM_DIR/bash_completion ]] && source $NVM_DIR/bash_completion
fi

[[ -r $HOME/.cargo/env ]] && source $HOME/.cargo/env

(( $+commands[go] )) && path+=("$(go env GOPATH)/bin")

if [[ -d ${PNPM_HOME:=${XDG_DATA_HOME:-$HOME/.local/share}/pnpm} ]]; then
  export PNPM_HOME
  path=($PNPM_HOME $path)
else
  unset PNPM_HOME
fi

#
# fzf
#
if (( $+commands[fzf] )); then
  # fzf >= 0.48 ships `fzf --zsh`; older installs drop a ~/.fzf.zsh instead.
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  elif [[ -r $HOME/.fzf.zsh ]]; then
    source $HOME/.fzf.zsh
  fi

  export FZF_TMUX=1
  export FZF_TMUX_OPTS='-p'
  (( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

  # Nord, to match the terminal and tmux themes.
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
fi

#
# Shell helpers
#
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[navi] ))   && eval "$(navi widget zsh)"

#
# dircolors — accept either filename; bash uses ~/.dircolors, this used to
# look only for ~/.dir_colors.
#
if (( $+commands[dircolors] )); then
  for _dc in $HOME/.dircolors $HOME/.dir_colors; do
    [[ -r $_dc ]] && { eval "$(dircolors -b $_dc)"; break }
  done
  unset _dc
fi

#
# shell-gpt, on Alt-g. The old binding was Ctrl-L, which cost us
# clear-screen.
#
if (( $+commands[sgpt] )); then
  _sgpt_zsh() {
    if [[ -n "$BUFFER" ]]; then
      _sgpt_prev_cmd=$BUFFER
      BUFFER+="⌛"
      zle -I && zle redisplay
      BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
      zle end-of-line
    fi
  }
  zle -N _sgpt_zsh
  bindkey '^[g' _sgpt_zsh
fi
