#!/bin/sh

# Only run if not already started
run() {
    if ! pgrep $1 > /dev/null; then
        $@ &
    fi
}

# Set screen resolution
xrandr -s 5120x1440 &

# Dropbox
caja-dropbox start -i &

# Network manager tray icon
nm-applet &

# Auto suspend after an hour unless mouse is in the lower right corner
xautolock \
    -time 60 \
    -locker "systemctl suspend" \
    -notify 60 \
    -notifier "notify-send -u critical -t 15000 -- 'Suspending in 60 seconds'" \
    -corners "000-" &
