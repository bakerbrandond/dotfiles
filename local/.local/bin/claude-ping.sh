#!/bin/sh
# Claude Code notification ping: tmux message + audible cue + terminal bell +
# dunst notification.
#
# Wired from ~/.claude/settings.json as the single Notification hook command.
# The hook payload arrives as JSON on stdin; a real one looks like:
#
#   {"session_id":"488fda76-...","transcript_path":"/home/bbd/.claude/...",
#    "cwd":"/home/bbd/dotfiles","prompt_id":"70507295-...",
#    "hook_event_name":"Notification",
#    "message":"Claude needs your permission",
#    "notification_type":"permission_prompt"}
#
# notification_type is the field settings.json's matcher tests, and it is what
# drives urgency, icon and sound below.
#
# Every stage is independently guarded: a missing tool or a stray field must
# never cost you the rest of the ping.

# jq/paplay/tmux come from homebrew; notify-send from /usr/bin.
PATH="/home/linuxbrew/.linuxbrew/bin:/usr/bin:/bin:$PATH"
export PATH

SOUNDS=/usr/share/sounds/freedesktop/stereo

payload=$(/bin/cat)

field() {
    printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null
}

msg=$(field '.message')
cwd=$(field '.cwd')
ntype=$(field '.notification_type')
sid=$(field '.session_id')

[ -n "$msg" ] || msg="Claude Code needs you"

# --- context: which project, and where to go to answer it ------------------
# With several sessions running at once, "which one is asking" is the first
# thing worth knowing, so it goes in the summary line.
project=$(basename "${cwd:-$HOME}")
home_rel=$(printf '%s' "${cwd:-}" | sed "s|^$HOME|~|")

where=""
if [ -n "$TMUX" ] && [ -n "$TMUX_PANE" ]; then
    where=$(tmux display-message -p -t "$TMUX_PANE" \
            'tmux #{session_name}:#{window_index}.#{pane_index}' 2>/dev/null)
fi
[ -n "$where" ] && [ -n "$home_rel" ] && where="$where · $home_rel"
[ -n "$where" ] || where="$home_rel"

# --- urgency, icon and sound by notification type --------------------------
# No -t: the timeouts live in dunstrc's [urgency_*] sections so there is one
# place that owns them (critical is timeout 0, i.e. waits for you).
case "$ntype" in
    permission_prompt)
        urgency=critical; icon=dialog-password;    sound="$SOUNDS/dialog-warning.oga" ;;
    agent_needs_input|elicitation_dialog)
        urgency=critical; icon=dialog-question;    sound="$SOUNDS/dialog-warning.oga" ;;
    idle_prompt)
        urgency=normal;   icon=dialog-information; sound="$SOUNDS/complete.oga" ;;
    *)
        urgency=normal;   icon=dialog-information; sound="$SOUNDS/complete.oga" ;;
esac

# --- 1. tmux status line ---------------------------------------------------
# tmux eats '#' as a format introducer, so double it.
if [ -n "$TMUX" ]; then
    tmux_msg=$(printf '%s' "$msg" | sed 's/#/##/g')
    tmux display-message "Claude Code: $tmux_msg" 2>/dev/null || true
fi

# --- 2. audible cue --------------------------------------------------------
paplay "$sound" 2>/dev/null &

# --- 3. terminal bell ------------------------------------------------------
if [ -n "$TMUX" ] && [ -n "$TMUX_PANE" ]; then
    pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
    [ -n "$pane_tty" ] && [ -w "$pane_tty" ] && printf '\a' > "$pane_tty" 2>/dev/null
fi

# --- 4. dunst --------------------------------------------------------------
# dunstrc sets markup = full, so &, < and > in the message must be escaped or
# pango drops the rest of the body.
esc() {
    printf '%s' "$1" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
}

# One stack tag per session: a session that pings repeatedly replaces its own
# notification instead of piling up, but two sessions stay two notifications.
notify-send \
    -a "Claude Code" \
    -u "$urgency" \
    -i "$icon" \
    -h "string:x-dunst-stack-tag:claude-${sid:-unknown}" \
    -h "string:category:${ntype:-unknown}" \
    "Claude · $project" \
    "$(esc "$msg")
<i>$(esc "$where")</i>" 2>/dev/null || true

exit 0
