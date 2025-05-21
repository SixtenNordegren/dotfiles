#!/usr/bin/env bash
CONFIG_HOME="$HOME/.config/"

read -p "Is $CONFIG_HOME the correct path for your config files(y/n)?" -n 1 -r
echo

if [ "$REPLY" = "y" ]; then
	stow -v -R -t "$CONFIG_HOME" files
else
	echo "Exiting, please edit the script and edit desired filepath."
	exit 1
fi

# Stow the config files in .ssh to CONFIG_HOME/ssh
# This assumes that the .ssh directory is a symlink to CONFIG_HOME/ssh

for file in "$CONFIG_HOME"ssh/*; do
		  # Check if the file is there already
		  if [ -e "$HOME/.ssh/$(basename "$file")" ]; then
					 echo "File $HOME/.ssh/$(basename "$file") already exists, skipping."
					 continue
		  else
					 echo "Creating symlink for $file"
					 ln -s "$file" "$HOME/.ssh/$(basename "$file")"
		  fi
done
