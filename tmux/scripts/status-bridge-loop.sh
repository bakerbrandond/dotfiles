#!/usr/bin/env bash
# Copy vimbridge files to stable paths tmux status bar reads (like battery-bridge).
dir="/private/tmp/tmux-$(id -u)"
lockdir="$dir/status-bridge.lock.d"
mkdir -p "$dir"

if ! mkdir "$lockdir" 2>/dev/null; then
  if pgrep -f 'status-bridge-loop\.sh' >/dev/null 2>&1; then
    exit 0
  fi
  rmdir "$lockdir" 2>/dev/null || rm -rf "$lockdir"
  mkdir "$lockdir" 2>/dev/null || exit 0
fi
trap 'rmdir "$lockdir" 2>/dev/null' EXIT

copy_bridge() {
  local src dst content old tmp
  src="$1"
  dst="$2"
  [[ -z "$src" || ! -f "$src" ]] && return 0

  content="$(tr -d '\n' <"$src" 2>/dev/null || true)"
  [[ -z "$content" ]] && return 0

  old=""
  [[ -f "$dst" ]] && old="$(tr -d '\n' <"$dst" 2>/dev/null || true)"
  [[ "$content" == "$old" ]] && return 0

  tmp="$dir/$(basename "$dst").tmp.$$"
  printf '%s' "$content" >"$tmp"
  mv -f "$tmp" "$dst"
}

while true; do
  left_src="$(env -u TMUX tmux display-message -p '#{socket_path}-#{session_id}-vimbridge' 2>/dev/null)"
  right_src="$(env -u TMUX tmux display-message -p '#{socket_path}-#{session_id}-vimbridge-R' 2>/dev/null)"

  copy_bridge "$left_src" "$dir/status-left-bridge"
  copy_bridge "$right_src" "$dir/status-right-bridge"

  sleep 2
done
