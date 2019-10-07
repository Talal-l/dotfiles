#!/bin/bash
ommandExist () { type "$1" &> /dev/null ;}

sudo apt-get install -y vim cmake tmux curl \
    virt-manager bridge-utils \
    qemu-kvm build-essential \
    python3 python3-dev \
    xclip


sudo apt-get install -y chrome-gnome-shell

sudo apt-get install -y wireshark transmission


# Vim setup

# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "Creating vim symlink"
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/colors ~/.vim/colors
ln -sf ~/dotfiles/vim/ftplugin ~/.vim/ftplugin
ln -sf ~/dotfiles/vim/UltiSnips ~/.vim/UltiSnips

# Create backup directory for vim
mkdir -p ~/.vim/backups


# Install vim plugins using Vundle
vim +PluginInstall +qall

# Compile YCM with python3
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --all



# VScode setup
sudo snap install vscode --classic

echo "Installing vscode extensions"
while read l; do
    code -f --install-extension $l
done < ~/dotfiles/vscode/extensions.txt
ln -sf ~/dotfiles/vscode/snippets ~/.config/Code/User/snippets
ln -sf ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json



# Bash
ln -sf  ~/dotfiles/bashrc ~/.bashrc
ln -sf  ~/dotfiles/bash_profile ~/.bash_profile

# Install Dracul theme
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula
./gnome-terminal-colors-dracula/install.sh -s Dracula --skip-dircolors
rm -rf gnome-terminal-colors-dracula

# Setup general symbolic links
ln -sf  ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/extra_config/eslintrc  ~/.eslintrc
ln -sf ~/dotfiles/extra_config/jsconfig.json ~/jsconfig.json



# Configure  gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then

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

    # Workspace navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Alt>j']"

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Alt>j']"
fi
