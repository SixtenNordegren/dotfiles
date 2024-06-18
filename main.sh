#!/usr/bin/env bash
FILEPATH=$(pwd) #This is not good design
CONFIGS=$(ls "$FILEPATH/files")
SCRIPT_DIR="$HOME/.config"
read -p "Is $SCRIPT_DIR the correct path for your config files(y/n)?" -n 1 -r
echo

install_config() {
	CHECKFILE="$FILEPATH/testdir/$FILE"
	if test -d "$CHECKFILE"; then
		echo "Found file, do nothing."
	else
		REPOPATH="$FILEPATH/files/$FILE"
		INSTALLPATH="$FILEPATH/testdir"

		cp -r "$REPOPATH" "$INSTALLPATH" && echo "Moved $FILE to $INSTALLPATH."
	fi
}

if [ "$REPLY" = "y" ]; then
	for FILE in $CONFIGS; do
		install_config
	done
else
	echo "Exiting, please edit the sctipt to input the correct filepath."
fi
