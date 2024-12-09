## Welcome this is a script that automates the installation of packages that I use when I install a new system.
## This script is for Ubuntu 20.04 LTS
## Some system packages are installed by default, so I will not install them here.
## Furthermore some packages are not available in the default repositories, or they are outdated so the are compiled from source.

# TODO:
# 1. Ensure that the needed fonts are included in the repo and installed properly. DONE
# 2. Ensure that the spelllist for the ltex lsp is included in the repo under the correct
# path. DONE
# 3. Solve the following error message for neovim:
# "Error detected while processing /root/Projects/dotfiles/files/nvim/init.lua:
# E5113: Error while calling lua chunk: /root/.config/nvim/lua/lua_scripts/ltex_dict.lua
# :3: attempt to index a nil value
# stack traceback:
#         /root/.config/nvim/lua/lua_scripts/ltex_dict.lua:3: in main chunk
#         [C]: in function 'require'
#         /root/Projects/dotfiles/files/nvim/init.lua:13: in main chunk" DONE
# 4. Find the missing dependencies for the neovim build, perticlarly for different lsps.
# Update on 4. The python-lsp-servers are the only ones that are missing.
# Still not working, might have something to do with externally managed
# environments. This is the error message that I get when trying to run
# PiP:error: externally-managed-environment
# × This environment is externally managed
# ╰─> To install Python packages system-wide, try apt install
#     python3-xyz, where xyz is the package you are trying to
#     install.
#
#     If you wish to install a non-Debian-packaged Python package,
#     create a virtual environment using python3 -m venv path/to/venv.
#     Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
#     sure you have python3-full installed.
#
#     If you wish to install a non-Debian packaged Python application,
#     it may be easiest to use pipx install xyz, which will manage a
#     virtual environment for you. Make sure you have pipx installed.
#
#     See /usr/share/doc/python3.12/README.venv for more information.
#
# note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
# hint: See PEP 668 for the detailed specification.


# Get the current directory
Current_Dir=$(pwd)

echo "make sure this script is run from the dotfiles directory, and is run with sudo"
read -p "Press y to continue, n to exit" -n 1 -r

# Check if the file system is created, i.e. the Documents, Downloads,
# Projects, and Tools directories are created.
# If they are not created, create them.
if [ ! -d ~/Documents ]; then
    mkdir ~/Documents ~/Downloads ~/Projects ~/Tools
fi

./stow_dotfiles.sh
# we need to stop the script here if the stow command fails
if [ $? -ne 0 ]; then
    echo "The stow command failed, please check the error message and try again."
    exit 1
fi

# Update and upgrade the system
apt update && apt upgrade -y
apt install -y xinit i3 firefox rofi python3-pip cargo vifm neomutt
# install transparency for i3
apt install -y compton
cargo install typeracer # Non-essential package, but fun to have

# Create github ssh key, only local side is done here. The public key still
# needs to be added to the github account.
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "sixten.nordegren@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
echo "Add the following key to your github account, it has been copied to the clipboard."
cat ~/.ssh/id_rsa.pub
xclip -sel clip < ~/.ssh/id_rsa.pub
read -p "Press enter to continue"

# set up Neovim
mkdir Tools
cd Tools
git clone https://github.com/neovim/neovim.git
cd neovim 
apt-get install ninja-build gettext cmake unzip curl build-essential # install the needed dependencies


# Non-essential dependencies
apt install nodejs npm ripgrep 
# Ensure we are on the stable branch
git checkout stable
make CMAKE_BUILD_TYPE=Release
make install

echo "Installing Zathura"
# Download zathura and install it, along the following plugins:
# zathura-pdf-poppler, zathura-ps, zathura-djvu
cd ~/Downloads
# Installing the girara dependency from source
git clone https://git.pwmt.org/pwmt/girara.git
cd girara 
meson build
cd build
ninja
ninja install

# Moving on to zathura
cd ~/Downloads
wget https://pwmt.org/projects/zathura/download/zathura-0.5.8.tar.xz
tar -xf zathura-0.5.8.tar.xz
cd zathura-0.5.8
# Install the dependencies including poppler-glib
apt install libgtk-3-dev libglib2.0-dev libgirara-dev libmagic-dev libjson-glib-dev libsqlite3-dev libsynctex-dev libseccomp-dev meson gettext pkgconf, libpoppler-glib-dev, lib-girara-gtk3-dev

# Install zathura
echo "Installing zathura..."
meson build
cd build
ninja
ninja install

# Install the plugins
# zathura-pdf-poppler
echo "Installing zathura-pdf-poppler..."
cd ~/Downloads
wget https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.3.3.tar.xz
tar -xf zathura-pdf-poppler-0.3.3.tar.xz
cd zathura-pdf-poppler-0.3.3
# Install the dependencies
apt install libpoppler-glib-dev
mkdir build
meson build
cd build
ninja
ninja install

# zathura-djvu
echo "Installing zathura-djvu..."
cd ~/Downloads
wget https://pwmt.org/projects/zathura-djvu/download/zathura-djvu-0.2.9.tar.xz
tar -xf zathura-djvu-0.2.9.tar.xz
cd zathura-djvu-0.2.9
# Install the dependencies
apt install libdjvulibre-dev
mkdir build
meson build
cd build
ninja
ninja install

# Clear the Downloads directory
rm -rf ~/Downloads/zathura*

# Download the hack font and install it
echo "Installing the Hack font..."
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip
mkdir -p ~/.local/share/fonts
mv Hack/*.ttf ~/.local/share/fonts

# Set alacritty as the default terminal
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

# Source the bashrc file from the dotfiles
rm ~/.bashrc
touch ~/.bashrc
cat "source ~/Projects/dotfiles/files/bashrc" >> ~/.bashrc

# Ensure the xinitrc starts i3
rm ~/.xinitrc
touch ~/.xinitrc
echo "exec i3" > ~/.xinitrc

cd Current_Dir
apt autoremove -y

echo "do startx to start the i3 window manager"
echo "Remember to add the public ssh key to your github account"
