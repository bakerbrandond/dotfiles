#!/usr/bin/env bash
# Background loop: refresh battery-bridge for tmux status bar.
dir="/private/tmp/tmux-$(id -u)"
script="${HOME}/.config/tmux/scripts/battery-pill.sh"
lockdir="$dir/battery-bridge.lock.d"
bridge="$dir/battery-bridge"
mkdir -p "$dir"

# Only one loop per user (tmux source-file spawns a new one each reload).
if ! mkdir "$lockdir" 2>/dev/null; then
  if pgrep -f 'battery-bridge-loop\.sh' >/dev/null 2>&1; then
    exit 0
  fi
  rmdir "$lockdir" 2>/dev/null || rm -rf "$lockdir"
  mkdir "$lockdir" 2>/dev/null || exit 0
fi
trap 'rmdir "$lockdir" 2>/dev/null' EXIT

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
