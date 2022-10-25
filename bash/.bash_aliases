alias gpg=gpg2
alias make=mmake
alias man=tldr
alias cat=bat
#alias ls=exa
#alias ll='exa -l'
alias f='fzf --preview "bat --color \"always\" {}"'
alias top=bpytop
alias ctop=cointop
alias aliasrc='vim ~/.alias'
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf.local'
#alias tmux='TERM=xterm-256color tmux'
alias tmux='tmux -2'

alias superslicer='docker stop /prusaslicer-novnc; docker run --detach --volume=superslicer-novnc-data:/configs/ -p 8080:8080 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" --name=superslicer-novnc mikeah/superslicer-novnc'
alias prusaslicer='docker stop /superslicer-novnc; docker run --detach --volume=prusaslicer-novnc-data:/configs/ -p 8080:8080 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" --name=prusaslicer-novnc mikeah/prusaslicer-novnc'
