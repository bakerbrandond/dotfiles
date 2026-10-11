#
# Homebrew.
#
# Covers all three machines: Apple Silicon, Intel macOS, and Linuxbrew. The
# first prefix that exists wins; no brew at all is a supported state.
#
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for _brew in \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew \
    $HOME/.linuxbrew/bin/brew
  do
    if [[ -x $_brew ]]; then
      eval "$($_brew shellenv)"
      break
    fi
  done
  unset _brew
fi

# Brew-installed completions, if any.
if [[ -n "$HOMEBREW_PREFIX" && -d $HOMEBREW_PREFIX/share/zsh/site-functions ]]; then
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi
