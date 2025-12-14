#!/bin/bash

set -euxo pipefail

RESOLUTION="1600x1200"

connect_tv() {
	xrandr --output "HDMI-1-5" --left-of "HDMI-3" --mode "1600x1200" >/dev/null
	pactl set-sink-mute alsa_output.pci-0000_10_00.1.hdmi-stereo false &
}

disconnect_tv() {
	xrandr --output "HDMI-1-5" --off >/dev/null
}

if xrandr | grep "HDMI-1-5" | grep -q "$RESOLUTION"; then
	disconnect_tv
else
	connect_tv
fi
