#!/bin/bash 

echo "Creating symlinks"
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s  ~/dotfiles/emacs.d ~/.emacs.d
ln -s  ~/dotfiles/emacs ~/.emacs
ln -s  ~/dotfiles/bashrc ~/.bashrc
ln -s  ~/dotfiles/tmux.conf ~/.tmux.conf

commandExist () { type "$1" &> /dev/null ;}




#........................VIM........................
# Install vim if not installed
if !commandExist vim; then 
    echo "Vim was not installed \n Instlling vim\n"
    sudo apt install vim -y
   
fi 

# Install vundle
if !commandExist git ;then
    echo "Git not installed\n Installing git...."
    sudo apt install git  -y 
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


# Install vim plugins using Vundle 
vim +PluginInstall +qall

# Create backup directory for vim
mkdir ~/.vim/backups

# YCM dependency 
sudo apt-get install build-essential cmake -y
sudo apt-get install python-dev python3-dev -y
# Compile YCM with python3
if !commandExist  python3; then
    echo "Python 3 not installed \n Installing python3"
    sudo apt install python3
fi

#python3 ~/.vim/bundle/YouCompleteMe/install.py --all
#........................VIM........................




#........................BASH.......................
# Install Dracul theme 
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula
./gnome-terminal-colors-dracula/install.sh -s Dracula -p Default --skip-dircolors
rm -rf gnome-terminal-colors-dracula

#........................BASH.......................




#........................SYSTEAM....................

# Remap CAP to Ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"


# Remap gnome terminal shortcuts
GSETTINGS_SCHEMA=org.gnome.Terminal.Legacy.Keybindings
GSETTINGS_PATH=/org/gnome/terminal/legacy/keybindings/
SCHEMA_PATH=$GSETTINGS_SCHEMA:$GSETTINGS_PATH


gsettings set $SCHEMA_PATH next-tab '<Control>l'
gsettings set $SCHEMA_PATH prev-tab '<Control>h'
gsettings set $SCHEMA_PATH new-tab '<Control>t'


# To list all available keybindings
# gsettings list-recursively | grep Terminal.Legacy.Keybindings


#........................SYSTEAM....................
