#!/usr/bin/env bash
# Lightweight battery segment for tmux status (no tmux subprocess calls).
# macOS reads pmset; Linux reads /sys/class/power_supply.

emit() {
  local icon="$1" percent="$2" remain="$3"
  [[ -z "$percent" ]] && return 0
  if [[ -n "$remain" ]]; then
    printf '%s %s ~%s' "$icon" "$percent" "$remain"
  else
    printf '%s %s' "$icon" "$percent"
  fi
}

# hh:mm left at the current rate. Units cancel, so energy/power (Wh laptops)
# and charge/current (Ah laptops) both work.
hhmm() {
  local now="$1" rate="$2" mins
  [[ "$now" =~ ^[0-9]+$ && "$rate" =~ ^[0-9]+$ ]] || return 0
  (( rate > 0 )) || return 0
  mins=$(( now * 60 / rate ))
  printf '%d:%02d' $(( mins / 60 )) $(( mins % 60 ))
}

if command -v pmset >/dev/null 2>&1; then
  power="$(pmset -g batt 2>/dev/null | sed -n '1p')"
  batt="$(pmset -g batt 2>/dev/null | sed -n '2p')"
  [[ -z "$batt" ]] && exit 0

  percent="$(printf '%s' "$batt" | grep -o '[0-9]\{1,3\}%' | head -1 || true)"
  status="$(printf '%s' "$batt" | awk -F '; *' '{gsub(/^ /, "", $2); print tolower($2)}')"
  remain="$(printf '%s' "$batt" | grep -o '[0-9]\{1,2\}:[0-9]\{2\}' | head -1 || true)"

  icon='🔌'
  [[ "$power" == *'Battery Power'* ]] && icon='🔋'
  [[ "$status" == *charged* || "$status" == *full* ]] && remain=''

  emit "$icon" "$percent" "$remain"
  exit 0
fi

batdir=''
for d in /sys/class/power_supply/BAT*; do
  [[ -d "$d" ]] || continue
  batdir="$d"
  break
done
[[ -z "$batdir" ]] && exit 0

capacity=''
status='Unknown'
[[ -r "$batdir/capacity" ]] && read -r capacity <"$batdir/capacity"
[[ -r "$batdir/status" ]] && read -r status <"$batdir/status"
[[ -z "$capacity" ]] && exit 0

icon='🔌'
[[ "$status" == 'Discharging' ]] && icon='🔋'

now='' rate='' full=''
if [[ -r "$batdir/energy_now" && -r "$batdir/power_now" ]]; then
  read -r now <"$batdir/energy_now"
  read -r rate <"$batdir/power_now"
  [[ -r "$batdir/energy_full" ]] && read -r full <"$batdir/energy_full"
elif [[ -r "$batdir/charge_now" && -r "$batdir/current_now" ]]; then
  read -r now <"$batdir/charge_now"
  read -r rate <"$batdir/current_now"
  [[ -r "$batdir/charge_full" ]] && read -r full <"$batdir/charge_full"
fi

remain=''
case "$status" in
  Discharging)
    remain="$(hhmm "$now" "$rate")"
    ;;
  Charging)
    if [[ "$full" =~ ^[0-9]+$ && "$now" =~ ^[0-9]+$ ]] && (( full > now )); then
      remain="$(hhmm "$(( full - now ))" "$rate")"
    fi
    ;;
esac

emit "$icon" "${capacity}%" "$remain"
