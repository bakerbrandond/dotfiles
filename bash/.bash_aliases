#alias gpg=gpg2
#alias make=mmake
#alias man=tldr
alias cat=bat
alias ls=exa
alias ll='exa -l'
alias f='fzf --preview "bat --color \"always\" {}"'
alias top=bpytop
alias ctop=cointop
alias vim='nvim'
alias aliasrc='vim ~/.alias'
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf'
alias tmx='tmux new-session -As 0'
#alias tmux='TERM=xterm-256color tmux'
#alias tmux='tmux -2'
#alias grep=rg
alias dc='docker-compose'
alias dclogs='docker-compose logs -f --tail=10'
alias dcrestart='docker-compose up -d --force-restart'
alias dcbounce='dc up -d --force-recreate'
#alias sgpt='docker run --rm --env OPENAI_API_KEY=$OPENAI_API_KEY --volume gpt-cache:/tmp/shell_gpt ghcr.io/ther1d/shell_gpt'
gptsay() {
    sgpt $1 | cowsay -f bong | lolcat -a -s 50
}
mkwifi() {
    nmcli dev wifi connect "$1" password "$2"
}
godoc () {
    go doc "$@" | chroma -l go -f terminal256 -s nord
}
alias lswifi='sudo iwlist wlp0s20f3 scan | grep -i ESSID'
#alias rm='rip'
alias ps='procs'
alias less='more'
alias lzd='lazydocker'
alias lzg='lazygit'
alias logout='gnome-session-quit'
alias vimgolf='docker run --rm -it -e "key=$VIMGOLF_KEY" ghcr.io/filbranden/vimgolf'
alias vimdiff='nvim -d'
#alias redshift='redshift -x || redshift -P -l 30.2672:-97.7333 -t 8000:1000 2>&1 &!'
alias leet="nvim leetcode.nvim"

# Import the colors.
. "${HOME}/.cache/wal/colors.sh"

# Create the alias.
alias dmen='dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15"'

function ya() {
    tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
alias scrot="scrot -s 'screenshot_%Y%m%d_%H%M%S.png' -e 'optipng $f && mkdir -p ~/Pictures/screenshots && mv $f ~/Pictures/screenshots && xclip -selection clipboard -t image/png -i ~/Pictures/screenshots/`ls -1 -t ~/Pictures/screenshots | head -1`'"
#alias scrot="scrot -s 'screenshot_%Y%m%d_%H%M%S.png' -e 'mkdir -p ~/Pictures/screenshots && mv $f ~/Pictures/screenshots && xclip -selection clipboard -t image/png -i ~/Pictures/screenshots/`ls -1 -t ~/Pictures/screenshots | head -1`'"

