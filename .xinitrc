#!/bin/sh

if [ -f '/usr/local/bin/monitors_local' ]; then
	(sleep 1 && '/usr/local/bin/monitors_local' >'/tmp/monitors_local.log.txt') &
	if [ $? -ne 0 ]; then
		echo 'Local monitors script crashed. Likley bad perms' >>'/tmp/monitors_local.log.txt'
	fi
fi

setxkbmap us -variant colemak

BROWSER_DESKTOP=org.qutebrowser.qutebrowser.desktop
xdg-mime default "$BROWSER_DESKTOP" x-scheme-handler/http
xdg-mime default "$BROWSER_DESKTOP" x-scheme-handler/https
xdg-mime default "$BROWSER_DESKTOP" text/html

exec '/usr/bin/ssh-agent' '/usr/bin/i3'
