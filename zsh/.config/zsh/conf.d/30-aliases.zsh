#
# Aliases and small functions.
#
# Previously inherited by sourcing ~/.bash_aliases, which assumed a dozen
# binaries and unconditionally sourced a pywal cache file. Each substitution
# below applies only when the replacement is installed.
#

# Config shortcuts
alias zshrc='${EDITOR:-vi} $ZDOTDIR/.zshrc'
alias aliasrc='${EDITOR:-vi} $ZDOTDIR/conf.d/30-aliases.zsh'
alias localrc='${EDITOR:-vi} ~/.zshrc.local'
alias vimrc='${EDITOR:-vi} ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua'
alias tmuxrc='${EDITOR:-vi} ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf'
alias tmx='tmux new-session -As 0'

# Tool substitutions, each gated on the tool being present. eza replaces exa,
# which is unmaintained; both are accepted so an older machine still works.
if (( $+commands[eza] )); then
  alias ls='eza'
  alias ll='eza -l --git'
  alias la='eza -la --git'
  alias lt='eza --tree --level=2'
elif (( $+commands[exa] )); then
  alias ls='exa'
  alias ll='exa -l'
  alias la='exa -la'
else
  alias ll='ls -alF'
  alias la='ls -A'
fi

(( $+commands[bat] ))        && alias cat='bat'
(( $+commands[batcat] ))     && alias cat='batcat'   # Debian/Ubuntu package name
(( $+commands[nvim] ))       && alias vim='nvim' && alias vimdiff='nvim -d'
(( $+commands[procs] ))      && alias ps='procs'
(( $+commands[bpytop] ))     && alias top='bpytop'
(( $+commands[lazydocker] )) && alias lzd='lazydocker'
(( $+commands[lazygit] ))    && alias lzg='lazygit'
(( $+commands[docker] ))     && {
  alias dc='docker compose'
  alias dclogs='docker compose logs -f --tail=10'
  alias dcbounce='docker compose up -d --force-recreate'
}

if (( $+commands[fzf] && $+commands[bat] )); then
  alias f='fzf --preview "bat --color=always {}"'
elif (( $+commands[fzf] )); then
  alias f='fzf'
fi

# yazi, cd-ing to wherever you left off
if (( $+commands[yazi] )); then
  ya() {
    local tmp="$(mktemp -t yazi-cwd.XXXXX)" cwd
    yazi --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
      cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

if (( $+commands[go] && $+commands[chroma] )); then
  godoc() { go doc "$@" | chroma -l go -f terminal256 -s nord }
fi
