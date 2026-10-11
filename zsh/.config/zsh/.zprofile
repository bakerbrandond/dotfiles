#
# Executes commands at login pre-zshrc.
#
# Environment and PATH live in conf.d/10-path.zsh and conf.d/20-brew.zsh so a
# non-login interactive shell gets them too (see zsh_conf_load in .zshenv).
# What stays here is login-only: agent sockets, secrets, tty-bound state.
#

#
# Editors, pager, language
#
# Each is only set when the tool exists, so a bare machine falls back to
# whatever the system default is instead of pointing at nothing.
#
if [[ -z "$EDITOR" ]]; then
  if (( $+commands[nvim] )); then
    export EDITOR='nvim' VISUAL='nvim'
  elif (( $+commands[vim] )); then
    export EDITOR='vim' VISUAL='vim'
  fi
fi

if [[ -z "$PAGER" ]]; then
  if (( $+commands[most] )); then
    export PAGER='most'
  else
    export PAGER='less'
  fi
fi

if [[ -z "$BROWSER" && "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -X -z-4'
fi

# Set the Less input preprocessor, trying both names it ships under.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Environment and PATH (shared with non-login shells)
#
zsh_conf_load 10-path.zsh 20-brew.zsh

#
# GPG
#
(( $+commands[gpg] || $+commands[gpg2] )) && export GPG_TTY=$TTY

#
# ssh-agent
#
# Reuse whatever is already there — a forwarded agent, 1Password, gnome-keyring,
# or launchd on macOS, which is why this is skipped entirely there. Only start
# an agent when nothing is listening, and keep its output so SSH_AUTH_SOCK
# actually survives (the old version redirected it to /dev/null and orphaned a
# fresh agent on every login).
#
if [[ -z "$SSH_AUTH_SOCK" && "$OSTYPE" != darwin* ]] && (( $+commands[ssh-agent] )); then
  _ssh_env="${XDG_STATE_HOME:-$HOME/.local/state}/ssh-agent.env"
  [[ -r $_ssh_env ]] && source $_ssh_env >/dev/null
  ssh-add -l &>/dev/null
  # ssh-add exits 2 when it cannot reach an agent at all (1 just means the
  # agent is running but holds no keys).
  if (( $? == 2 )); then
    mkdir -p ${_ssh_env:h}
    ssh-agent -s >| $_ssh_env
    source $_ssh_env >/dev/null
  fi
  unset _ssh_env
fi

#
# Secrets
#
# bash/.secrets is git-crypt encrypted. On a machine where the repo is still
# locked it is binary data, so check that it parses before sourcing it;
# otherwise every login fills with parse errors.
#
if [[ -r ~/.secrets ]] && zsh -n ~/.secrets 2>/dev/null; then
  source ~/.secrets
  [[ -n "$GSPT_ID" ]] && export SPOTIFY_ID="$GSPT_ID"
  [[ -n "$GSPT_SECRET" ]] && export SPOTIFY_SECRET="$GSPT_SECRET"
fi
