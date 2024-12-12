## This is a script that automates the installation of packages for Arch Linux.

# Ensure the script is not run as root and run from the correct directory
if [ "$(pwd)" != "$(dirname "$(realpath "$0")")" ]; then
	echo "Please run the script from the home directory of the repository."
	exit 1
fi
if [ $EUID -eq 0 ]; then
	echo "This script should not be run as root. Please run it as a regular user."
	exit 1
fi

# Update the system and install essential packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm xorg-server xorg-xinit i3-wm firefox rofi python-pip cargo vifm neomutt picom base-devel git neovim zathura zathura-pdf-mupdf zathura-djvu alacritty nodejs npm ripgrep stow mandoc man-db ssh-tools xorg-twm xorg-xclock xterm wget unzip xclip todotxt

# Create necessary directories if they don't exist
mkdir -p ~/downloads ~/projects ~/tools ~/.local ~/.local/share ~/.local/share/fonts

./stow_dotfiles.sh

if [ $? -ne 0 ]; then # This only works when it properly crashes. If it just doesn't link it does'nt recognize it as a failure. Need to edit s
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

# Ensure scripts are executable
chmod +x scripts/decryptfile.sh scripts/encryptfile.sh files/i3/scripts/*

# Decrypt sensitive files
./scripts/decryptfile.sh ./files/neomutt/accounts/gmail/gmailrc.encrypted ./files/neomutt/accounts/gmail/gmailrc

# Install Hack Nerd Font
cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm -rf Hack*

rm -f ~/.bashrc
rm -f ~/.xinitrc

echo "source ~/.config/bash/bashrc" > ~/.bashrc
echo "source ~/.config/xinit/xinitrc" > ~/.xinitrc

pacman -Rns "$(pacman -Qdtq)" --noconfirm
rm ~/downloads/*

echo "Setup complete! Run 'startx' to start the i3 window manager."
echo "Don't forget to add the public SSH key to your GitHub account."
