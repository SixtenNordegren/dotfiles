## Welcome this is a script that automates the installation of packages that I use when I install a new system.
## This script is for Ubuntu 20.04 LTS
## Some system packages are installed by default, so I will not install them here.
## Furthermore some packages are not available in the default repositories, or they are outdated so I will compile them from source.

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

# Get the current directory
Current_Dir=$(pwd)

# Install the dotfiles
./install_dotfiles.sh

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y
sudo apt install -y xinit i3 firefox rofi python3-pip lightdm 

# Create desired directories
mkdir -p ~/downloads ~/projects ~/tools ~/.local ~/.local/bin ~/.config

# Create github ssh key
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "sixten.nordegren@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
echo "Add the following key to your github account, it has been copied to the clipboard."
cat ~/.ssh/id_rsa.pub
# can we make it copy the key to the clipboard?
xclip -sel clip < ~/.ssh/id_rsa.pub
read -p "Press enter to continue"


cd tools

# set up neovim
git clone https://github.com/neovim/neovim.git
cd neovim 
sudo apt-get install ninja-build gettext cmake unzip curl build-essential # install the needed dependencies

# Non-essential dependencies
sudo apt install nodejs npm ripgrep 
pip install jedi-language-server 
make CMAKE_BUILD_TYPE=Release
sudo make install

# download the hack font and install it
cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
unzip Hack.zip
mkdir -p ~/.local/share/fonts
mv Hack/*.ttf ~/.local/share/fonts

# download my project repos
cd ~/projects
git clone git@github.com:SixtenNordegren/CFT_notes.git
git clone git@github.com:SixtenNordegren/MSc.git
