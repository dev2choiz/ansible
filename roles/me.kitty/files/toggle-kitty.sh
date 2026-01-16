#!/usr/bin/env bash

TARGET="kitty-dropdown"
WINID=$(xdotool search --class "$TARGET" | head -n 1)

if [ -z "$WINID" ]; then
    # kitty window not found => launch it
    kitty --class "$TARGET" &
else
    # toggle minimize / restore
    STATE=$(xdotool getwindowfocus 2>/dev/null)
    if [ "$STATE" = "$WINID" ]; then
        # focused => minimize
        xdotool windowminimize $WINID
    else
        # not focused => restore + focus
        xdotool windowmap $WINID
        xdotool windowactivate $WINID
    fi
fi
