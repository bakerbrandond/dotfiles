#
# macOS only (sourced by zsh_conf_load when $OSTYPE is darwin*).
#

alias clip='pbcopy'
alias o='open'

# Prefer GNU coreutils/gawk when they are brew-installed, so scripts written
# against the Linux machines behave the same here.
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  path=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N)
    $HOMEBREW_PREFIX/opt/gawk/libexec/gnubin(N)
    $HOMEBREW_PREFIX/opt/libpq/bin(N)
    $path
  )
fi

# Building x86 images on Apple Silicon.
[[ $CPUTYPE == arm64 ]] && export DOCKER_DEFAULT_PLATFORM=linux/amd64
