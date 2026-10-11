#!/usr/bin/env bash
# Lightweight battery segment for tmux status (no tmux subprocess calls).

power="$(pmset -g batt 2>/dev/null | sed -n '1p')"
batt="$(pmset -g batt 2>/dev/null | sed -n '2p')"
[[ -z "$batt" ]] && exit 0

percent="$(printf '%s' "$batt" | grep -o '[0-9]\{1,3\}%' | head -1 || true)"
status="$(printf '%s' "$batt" | awk -F '; *' '{gsub(/^ /, "", $2); print tolower($2)}')"
remain="$(printf '%s' "$batt" | grep -o '[0-9]\{1,2\}:[0-9]\{2\}' | head -1 || true)"

icon='🔌'
if [[ "$power" == *'Battery Power'* ]]; then
  icon='🔋'
fi

if [[ "$status" == *charged* || "$status" == *full* ]]; then
  printf '%s %s' "$icon" "$percent"
elif [[ -n "$remain" ]]; then
  printf '%s %s ~%s' "$icon" "$percent" "$remain"
else
  printf '%s %s' "$icon" "$percent"
fi
