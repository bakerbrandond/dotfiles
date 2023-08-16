# use UTF-8 everywhere
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export XCURSOR_SIZE=24

# graphic acceleration for Firefox
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# allow web assembly in Chromium
export ENABLE_WASM=1

# specify location of kshrc
export ENV=$HOME/.kshrc

# load Xresources file
xrdb -merge $HOME/.Xresources

# suppress blue light at night
redshift -l 40.2732:-76.8867 -g 0.9 &

# Eigengrau background with symbol
~/.fehbg &

# xidle will lock your display after a period of inactivity
xidle -timeout 300 &

# disable system beep
xset b off

# use caps lock as compose key
setxkbmap -option compose:caps

# press both shift keys for caps lock
setxkbmap -option shift:both_capslock

# start up a dbus session so that Emacs doesn't hang.
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
  eval `dbus-launch --sh-syntax --exit-with-x11`
fi

# reset fontpath
xset fp default

# set extra dirs in fontpath, if any
if [ -d /usr/local/share/fonts ]; then
  for i in /usr/local/share/fonts/*; do
    xset fp+ $i
  done
  xset fp rehash
fi

# sadly, xclock has a bug where the font selection is ignored when UTF-8
# is enabled, so we unset LANG here.
USER=$(whoami)
HOST=$(hostname -s)
LANG= xclock -strftime "$USER@$HOST | %m/%d/%Y %H:%M" -geometry -10-10 -render -face "Noto Mono:pixelsize=24" &

# pump up the volume
doas mixerctl outputs.master=255,255

# start window mangler
exec cwm

exec betterlockscreen -w dim
