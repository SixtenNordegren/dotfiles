## This is a script that automates the installation of packages for Arch Linux.

# Ensure the script is not run as root
if [ $EUID -eq 0 ]; then
	echo "This script should not be run as root. Please run it as a regular user."
	exit 1
fi

# Update the system and install essential packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm xorg-server xorg-xinit i3-wm firefox rofi python-pip cargo vifm neomutt picom base-devel git neovim zathura zathura-pdf-mupdf zathura-djvu alacritty nodejs npm ripgrep

# Create necessary directories if they don't exist
mkdir -p ~/downloads ~/projects ~/tools

# Stow dotfiles
./stow_dotfiles.sh
if [ $? -ne 0 ]; then # This does not work for some reason, need to add proper flags to stow_dotfiles.sh
	echo "The stow command failed. Please check the error message and try again."
	exit 1
fi

# Set up SSH key for GitHub
rm -rf ~/.ssh
mkdir -p ~/.ssh && cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "sixten.nordegren@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -sel clip
read -p "SSH key copied to clipboard. Add it to your GitHub account and press enter to continue."

# Install Hack Nerd Font
cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm -rf Hack*

# Set alacritty as the default terminal emulator
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50

# Source bashrc from dotfiles
rm -f ~/.bashrc
ln -s ~/projects/dotfiles/files/bashrc ~/.bashrc

# Set up xinit to start i3
rm -f ~/.xinitrc
echo "exec i3" >~/.xinitrc

# Cleanup
pacman -Rns "$(pacman -Qdtq)" --noconfirm
rm ~/Downloads/*

# Finish up
echo "Setup complete! Run 'startx' to start the i3 window manager."
echo "Don't forget to add the public SSH key to your GitHub account."
