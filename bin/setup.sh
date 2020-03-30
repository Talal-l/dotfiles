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

# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    commandExist git
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

msg "Creating vim symlink"
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/colors ~/.vim/colors
ln -sf ~/dotfiles/vim/ftplugin ~/.vim/ftplugin
ln -sf ~/dotfiles/vim/UltiSnips ~/.vim/UltiSnips

# Create backup directory for vim
mkdir -p ~/.vim/backups


# Install vim plugins using Vundle
vim +PluginInstall +qall

# Compile YCM with python3
msg "Compiling YCM"
if ! [ -e ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]; then 
    python3 ~/.vim/bundle/YouCompleteMe/install.py --ts-completer --cs-completer --clang-completer --go-completer --rust-completer 
fi


msg "VScode setup"

sudo snap install code --classic
cat ~/dotfiles/vscode/extensions.txt | xargs -L 1 /snap/bin/code --install-extension
ln -sf ~/dotfiles/vscode/snippets ~/.config/Code/User/snippets
ln -sf ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json





msg "Installing Dracul theme"
$repo_path/bin/dracula.sh

msg "Setting up general symbolic links"
ln -sf  ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/extra_config/eslintrc  ~/.eslintrc
ln -sf ~/dotfiles/extra_config/jsconfig.json ~/jsconfig.json
ln -sf  ~/dotfiles/bashrc ~/.bashrc
ln -sf  ~/dotfiles/bash_profile ~/.bash_profile


# Configure  gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then

    # Remap CAP to Ctrl
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

    # To list all available keybindings
    # gsettings list-recursively | grep Terminal.Legacy.Keybindings

    # Workspace navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Alt>j']"

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Alt>k']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Alt>j']"
fi
