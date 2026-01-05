#!/bin/bash

set -euxo pipefail

RESOLUTION="1600x1200"
TV_SINK="alsa_output.pci-0000_10_00.1.hdmi-stereo"
OTHER_SINK="alsa_output.pci-0000_10_00.6.analog-stereo"

connect_tv() {
	xrandr --output "HDMI-1-5" --left-of "HDMI-3" --mode "$RESOLUTION" >/dev/null
	pactl set-sink-mute "$TV_SINK" false &
}

disconnect_tv() {
	xrandr --output "HDMI-1-5" --off >/dev/null
	pactl set-sink-mute "$OTHER_SINK" false &
}

if xrandr | grep "HDMI-1-5" | grep -q "$RESOLUTION"; then
	disconnect_tv
else
	connect_tv
fi
