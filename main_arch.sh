## This is a script that automates the installation of packages for Arch Linux.

# Ensure the script is not run as root and run from the correct directory.
if [ "$(pwd)" != "$(dirname "$(realpath "$0")")" ]; then
	echo "Please run the script from the home directory of the repository."
	exit 1
fi
PROJECT_DIR=$(pwd)
if [ $EUID -eq 0 ]; then
	echo "This script should not be run as root."
	exit 1
fi

echo "Please enter the password for the encrypted files:"
read -s PASSWORD
echo "Did you type the password correctly? (y/n)"
read CONFIRM
if [ $CONFIRM != "y" ]; then
	echo "Please re-run the script."
	exit 1
fi

./stow_dotfiles.sh
if [ $? -ne 0 ]; then
	echo "The stow command failed or was interrupted."
	exit 1
fi

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed $(cat package_bundles/package_bundle_1)
if [ $? -ne 0 ]; then
	echo "The installation of package_bundle_1 failed."
	exit 1
fi

# Create necessary directories if they don't exist already.
mkdir -p ~/downloads ~/projects ~/tools ~/.local ~/.local/share ~/.local/share/fonts ~/.local/bin

# Install AUR helper.
cd ~/downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install packages from AUR.
yay -S --noconfirm todotxt

# Set up SSH key for GitHub.
rm -rf ~/.ssh
mkdir -p ~/.ssh && cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "sixten.nordegren@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -sel clip
read -p "SSH key copied to clipboard. Add it to your GitHub account and press enter to continue."

# Set up git.
git config --global user.name "Sixten Nordegren"
git config --global user.email "sixten.nordegren@gmail.com"
git config --global core.editor "nvim"
git config --global core.pager "nvim -R"
git config --global color.pager no
git config --global init.defaultBranch "main"

# Ensure scripts are executable.
chmod +x scripts/* files/i3/scripts/*

# Decrypt sensitive files.
./scripts/decryptfile.sh $PASSWORD ./files/neomutt/accounts/gmail/gmailrc.encrypted ./files/neomutt/accounts/gmail/gmailrc

# Install Hack Nerd Font.
cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm -rf Hack*

echo "source ~/.config/bash/bashrc" > ~/.bashrc
echo "source ~/.config/xinit/xinitrc" > ~/.xinitrc

# Add sources to wikiman and install.
cd ~/downloads
git clone https://github.com/filiparag/wikiman.git
cd wikiman
sudo make source-arch
sudo make source-install

echo "Installing arch-wiki-docs..."
wikiman -S

# Set timezone to Europe/Stockholm.
sudo timedatectl set-timezone Europe/Stockholm

# Add python virtual environment to PATH.
python3 -m venv ~/.venv

# Link pagerscript to local bin directory.
cd "$PROJECT_DIR"
ln -s scripts/viman.sh ~/.local/bin/viman

# Clean up
pacman -Rns "$(pacman -Qdtq)" --noconfirm
rm ~/downloads/*
PASSWORD=""
echo "Clearing password from memory."
echo "---------------------------------"
echo " "
echo "Setup complete!"
echo "Reboot if you haven't already."
echo "Don't forget to add the public SSH key to your GitHub account."
