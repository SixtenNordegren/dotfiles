#!/usr/bin/env bash
FILEPATH="$HOME/Projects/dotfiles"
SCRIPT_DIR="$HOME/.config/"

install_config() {
	REPOPATH="$FILEPATH/files/$FILE"
	INSTALLPATH="$FILEPATH/experiment_directory"

	ln -f "$REPOPATH" "$INSTALLPATH" && echo "Moved $FILE to $INSTALLPATH."
}

read -p "Is $SCRIPT_DIR the correct path for your config files(y/n)?" -n 1 -r
echo

if [ "$REPLY" = "y" ]; then
	stow -v -R -t "$SCRIPT_DIR" files
else
	echo "Exiting, please edit the script and edit desired filepath."
fi
