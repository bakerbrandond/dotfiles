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

clear_bridge() {
  local dst="$1" old tmp
  old=""
  [[ -f "$dst" ]] && old="$(tr -d '\n' <"$dst" 2>/dev/null || true)"
  [[ -z "$old" ]] && return 0

  tmp="$dir/$(basename "$dst").tmp.$$"
  : >"$tmp"
  mv -f "$tmp" "$dst"
}

copy_bridge() {
  local src dst content old tmp
  src="$1"
  dst="$2"

  if [[ -z "$src" || ! -f "$src" ]]; then
    clear_bridge "$dst"
    return 0
  fi

  content="$(tr -d '\n' <"$src" 2>/dev/null || true)"
  if [[ -z "$content" ]]; then
    clear_bridge "$dst"
    return 0
  fi

  old=""
  [[ -f "$dst" ]] && old="$(tr -d '\n' <"$dst" 2>/dev/null || true)"
  [[ "$content" == "$old" ]] && return 0

  tmp="$dir/$(basename "$dst").tmp.$$"
  printf '%s' "$content" >"$tmp"
  mv -f "$tmp" "$dst"
}

resolve_vimbridge() {
  local suffix="$1" socket sid num
  socket="$(env -u TMUX tmux display-message -p '#{socket_path}' 2>/dev/null)"
  sid="$(env -u TMUX tmux display-message -p '#{session_id}' 2>/dev/null)"
  [[ -z "$socket" || -z "$sid" ]] && return 1

  num="${sid#\$}"
  # Prefer tpipeline#get_filepath() (init.lua sets TMUX third field to session num).
  if [[ -f "${socket}-${num}-vimbridge${suffix}" ]]; then
    printf '%s\n' "${socket}-${num}-vimbridge${suffix}"
    return 0
  fi
  # Legacy path when TMUX third field was the session id string (e.g. default-$0-vimbridge).
  if [[ -f "${socket}-${sid}-vimbridge${suffix}" ]]; then
    printf '%s\n' "${socket}-${sid}-vimbridge${suffix}"
    return 0
  fi
  printf '%s\n' "${socket}-${num}-vimbridge${suffix}"
}

pane_has_vim() {
  local cmd
  cmd="$(env -u TMUX tmux display-message -p '#{pane_current_command}' 2>/dev/null || true)"
  [[ "$cmd" == "nvim" || "$cmd" == "vim" ]]
}

while true; do
  if ! pane_has_vim; then
    clear_bridge "$dir/status-left-bridge"
    clear_bridge "$dir/status-right-bridge"
    sleep 2
    continue
  fi

  left_src="$(resolve_vimbridge "")"
  right_src="$(resolve_vimbridge "-R")"

  copy_bridge "$left_src" "$dir/status-left-bridge"
  copy_bridge "$right_src" "$dir/status-right-bridge"

  sleep 2
done
