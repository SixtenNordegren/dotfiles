#!/usr/bin/env bash
FILEPATH="/home/sixten/Projects/dotfiles/"
CONFIGS=$(ls "$FILEPATH/files")
# SCRIPT_DIR="$HOME/.config"
SCRIPT_DIR="$HOME/Projects/dotfiles/experiment_directory"

# (1) Select file.
# (2) Go to target folder.
# (3) If link exists in target folder, overwrite it.
# (4) If file exists in repo but not in folder link to it.
# (Not sure if to implement) If link exists in target folder but not in repo, delete it. But what
# about external dependencies?

# We are currently leaving old config files in the directory. Consider
# making a to delete list.
install_config() {
	CHECKFILE="$FILEPATH/experiment_directory/$FILE"
	if test -d "$CHECKFILE"; then
		echo "Found file, do nothing."
	else
		REPOPATH="$FILEPATH/files/$FILE"
		INSTALLPATH="$FILEPATH/experiment_directory"

		ln -f "$REPOPATH" "$INSTALLPATH" && echo "Moved $FILE to $INSTALLPATH."
	fi
}

read -p "Is $SCRIPT_DIR the correct path for your config files(y/n)?" -n 1 -r
echo

if [ "$REPLY" = "y" ]; then
	for FILE in $CONFIGS; do
		install_config
	done
else
	echo "Exiting, please edit the sctipt to input the correct filepath."
fi
