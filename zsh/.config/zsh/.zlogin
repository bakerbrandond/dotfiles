#
# Executes commands at login post-zshrc.
#
# The completion dump is compiled in conf.d/90-completion.zsh now; the block
# that used to live here pointed at a prezto cache path that nothing writes.
#

# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then

  # Print a random, hopefully interesting, adage.
  if (( $+commands[fortune] )); then
    fortune -s
    print
  fi

fi >&2
