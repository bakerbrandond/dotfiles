#
# PATH and fpath.
#
# Every entry is conditional on the directory existing, so a machine without
# a given toolchain just doesn't get that entry. `typeset -gU path` in .zshenv
# removes duplicates, so this file is safe to re-enter.
#

path=(
  $HOME/.local/bin(N)
  $HOME/bin(N)
  $HOME/.cargo/bin(N)
  /usr/local/bin(N)
  /usr/local/sbin(N)
  $path
)

# Repo-local completions (the three cobra-generated ones live here), plus
# anything dropped in by hand.
fpath=(
  $ZDOTDIR/completions(N)
  $HOME/.zsh.d(N)
  $fpath
)
