#!/bin/bash
commandExist () { 
    if ! type "$1" > /dev/null; then
        msg "$1 is not installed"
        exit 127
    fi
}

msg(){
echo "######## $1 ########"
}

repo_path="$HOME/dotfiles"

# Make sure clock is up to date (needed after restoring vm from snapshot)
# remove unattended-upgrades to prevent it from hogging the lock
sudo apt-get remove -y unattended-upgrades
sudo systemctl restart systemd-timesyncd
sudo sed -i 's/\/.*\.archive/\/\/archive/' /etc/apt/sources.list

sudo apt-get update

msg "Installing pacakges"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y $(cat "$repo_path/extra_config/pkglist.txt")

# Vim setup

msg "vim setup"
# Install vim-plug
vimPlugFile="${XDG_DATA_HOME:-$HOME/.local/share/nvim/site/autoload/plug.vim}"
if [ ! -f vimPlugFile ]; then
    commandExist curl
    # TODO: How to make this safer?
    curl -fLo $vimPlugFile --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ln -sf ~/dotfiles/nvim ~/.config/nvim

# Create backup directory for vim
mkdir -p ~/.vim/backups

# Install vim plugins using plug 
nvim -es -i NONE -c "PlugInstall" -c "qa"


msg "Setting up general symbolic links"
ln -sf  ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/extra_config/eslintrc  ~/.eslintrc
ln -sf ~/dotfiles/extra_config/jsconfig.json ~/jsconfig.json
ln -sf  ~/dotfiles/bashrc ~/.bashrc
ln -sf  ~/dotfiles/bash_profile ~/.bash_profile
ln -sf  ~/dotfiles/ideavimrc ~/.ideavimrc


# Configure  gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    # To list all available keybindings
    # gsettings list-recursively | grep Terminal.Legacy.Keybindings

    # Workspace navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Alt>j']"

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Alt>j']"
fi
