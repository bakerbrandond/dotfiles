#!/usr/bin/env bash
# Background loop: refresh battery-bridge for tmux status bar.
# Deliberately not /tmp/tmux-$uid — that is tmux's own socket dir on Linux.
dir="/tmp/tmux-status-$(id -u)"
script="${HOME}/.config/tmux/scripts/battery-pill.sh"
lockdir="$dir/battery-bridge.lock.d"
bridge="$dir/battery-bridge"
mkdir -p "$dir"

# Only one loop per user (tmux source-file spawns a new one each reload).
# The owner's pid lives in the lock, so a lock orphaned by SIGKILL is
# recoverable — pgrep cannot do this, it always matches this script itself.
acquire_lock() {
  local owner=''
  if mkdir "$lockdir" 2>/dev/null; then
    printf '%s' "$$" >"$lockdir/pid"
    return 0
  fi
  [[ -r "$lockdir/pid" ]] && read -r owner <"$lockdir/pid"
  if [[ "$owner" =~ ^[0-9]+$ ]] && kill -0 "$owner" 2>/dev/null; then
    return 1
  fi
  rm -rf "$lockdir"
  mkdir "$lockdir" 2>/dev/null || return 1
  printf '%s' "$$" >"$lockdir/pid"
}

acquire_lock || exit 0
trap 'rm -rf "$lockdir" 2>/dev/null' EXIT

write_bridge() {
  local tmp content old
  tmp="$dir/battery-bridge.tmp.$$"
  if ! "$script" >"$tmp" 2>/dev/null || [[ ! -s "$tmp" ]]; then
    rm -f "$tmp"
    return 1
  fi
  content="$(tr -d '\n' <"$tmp")"
  rm -f "$tmp"
  [[ -z "$content" ]] && return 1

  old=""
  [[ -f "$bridge" ]] && old="$(tr -d '\n' <"$bridge")"
  [[ "$content" == "$old" ]] && return 0

  tmp="$dir/battery-bridge.tmp.$$"
  printf '%s' "$content" >"$tmp"
  mv -f "$tmp" "$bridge"
}

while true; do
  write_bridge
  sleep 60
done
