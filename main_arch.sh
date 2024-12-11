## This is a script that automates the installation of packages for Arch Linux.

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Update the system and install essential packages
pacman -Syu --noconfirm
pacman -S --noconfirm xorg-xinit i3-wm firefox rofi python-pip cargo vifm neomutt picom base-devel git neovim zathura zathura-pdf-mupdf zathura-djvu alacritty nodejs npm ripgrep

# Optional fun package
cargo install typeracer 

# Create necessary directories if they don't exist
mkdir -p ~/Documents ~/Downloads ~/Projects ~/Tools

# Stow dotfiles
./stow_dotfiles.sh
if [ $? -ne 0 ]; then
    echo "The stow command failed. Please check the error message and try again."
    exit 1
fi

# Set up SSH key for GitHub
rm -rf ~/.ssh
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "sixten.nordegren@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -sel clip
read -p "SSH key copied to clipboard. Add it to your GitHub account and press enter to continue."

# Install Hack Nerd Font
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
rm -rf Hack*

# Set alacritty as the default terminal emulator
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50

# Source bashrc from dotfiles
rm -f ~/.bashrc
ln -s ~/Projects/dotfiles/files/bashrc ~/.bashrc

# Set up xinit to start i3
rm -f ~/.xinitrc
echo "exec i3" > ~/.xinitrc

# Cleanup
pacman -Rns $(pacman -Qdtq) --noconfirm

# Finish up
echo "Setup complete! Run 'startx' to start the i3 window manager."
echo "Don't forget to add the public SSH key to your GitHub account."
