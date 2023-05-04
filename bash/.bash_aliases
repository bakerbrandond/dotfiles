#alias gpg=gpg2
#alias make=mmake
alias man=tldr
alias cat=bat
alias ls=exa
alias ll='exa -l'
alias f='fzf --preview "bat --color \"always\" {}"'
alias top=bpytop
alias ctop=cointop
alias aliasrc='vim ~/.alias'
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf.local'
#alias tmux='TERM=xterm-256color tmux'
alias tmux='tmux -2'
alias grep=rg
#alias cds ='cd ~/src/pushnami/pushnami-docker-dev/services'
alias dc='docker-compose'
alias dclogs='docker-compose logs -f --tail=10'
alias dcrestart='docker-compose up -d --force-restart'
alias dcbounce='dc up -d --force-recreate'
alias vim='/opt/homebrew/bin/vim'
alias sgpt='docker run --rm --env OPENAI_API_KEY=$OPENAI_API_KEY --volume gpt-cache:/tmp/shell_gpt sgpt'
gptsay() {
  sgpt $1 | cowsay -f bong | lolcat -a -s 50
}
alias rm='rip'
alias ps='procs'
alias less='more'
alias lzd='lazydocker'
alias lzg='lazygit'
