#zstyle ':omz:update' mode auto

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  #source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi

# source antidote
#source ${ZDOTDIR:-~}/.antidote/antidote.zsh
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Customize to your needs...
#plugins=(
  #asdf
  #httpie
  #kubectl
  #fzf
  #docker
  #docker-compose
  #git
  #gpg-agent
  #keychain
  #dotenv
  #npm
  #tmux
  #redis-cli
  #brew
  #macos
#)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(navi widget zsh)"
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# OSX Homebrew
#source /opt/homebrew/opt/asdf/libexec/asdf.sh
# TODO
# Linuxbrew
source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.bash_aliases

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

export READER=zathura
export PATH="$HOME/latexrun:$PATH"
export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

# pnpm
export PNPM_HOME="/home/bbaker/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end