#!/bin/sh
# Re-apply the pywal colorscheme and restart the consumers that cannot pick up
# new colors on their own.
#
#   wal-reload.sh                          restore the cached scheme
#   wal-reload.sh --theme base16-nord      switch theme
#   wal-reload.sh -i ~/Pictures/foo.png    generate from an image
#
# Anything that reads ~/.cache/wal/* at launch (rofi via its @import, the shell
# via colors.sh) needs nothing here - it picks the new colors up next time it
# starts. dunst is different: it reads dunstrc.d/99-wal.conf only at startup and
# dunst 1.9 has no `dunstctl reload`, so it has to be restarted.

set -eu

# -s  Do NOT push escape sequences into open terminals. pywal writes its
#     palette to every /dev/pts/* by default (pywal/sequences.py: `if to_send:`),
#     but this setup does not use wal for terminal colors - the
#     `cat ~/.cache/wal/sequences` line in ~/.zshrc is commented out and ghostty
#     carries its own theme. Without -s, every live pane gets its palette and
#     background overridden, which also breaks ghostty's background-opacity.
#     -s still writes ~/.cache/wal/sequences and all templates.
# -t  Same, for the tty.
# -e  Skip wal's gtk/xrdb/i3/sway/polybar reload; polybar reads its own colors.
# -n  Leave the wallpaper to feh in bspwmrc.
WAL_FLAGS="-q -s -t -e -n"

if [ "$#" -eq 0 ]; then
    wal $WAL_FLAGS -R
else
    wal $WAL_FLAGS "$@"
fi

# The new colors only exist once wal has rendered the template.
if [ ! -e "$HOME/.cache/wal/dunst-colors.conf" ]; then
    echo "wal-reload: ~/.cache/wal/dunst-colors.conf missing - is" \
         "~/.config/wal/templates/dunst-colors.conf stowed?" >&2
    exit 1
fi

if pgrep -x dunst > /dev/null 2>&1; then
    pkill -x dunst || true
    # Wait for it to release org.freedesktop.Notifications, otherwise the new
    # instance loses the race for the bus name and exits.
    i=0
    while pgrep -x dunst > /dev/null 2>&1 && [ "$i" -lt 30 ]; do
        sleep 0.1
        i=$((i + 1))
    done
fi

# setsid so dunst survives the terminal this script was run from.
setsid dunst > /dev/null 2>&1 &

echo "wal-reload: colors regenerated, dunst restarted"
