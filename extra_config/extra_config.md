# Linux

## Install vundle 
mkdir ~/.vim/backups

`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

## YCM

Install development tools and CMake: 
    sudo apt-get install build-essential cmake

    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer

Make sure you have Python headers installed: 
    sudo apt-get install python-dev python3-dev

## additional component for  Instant markdown preview 
     
    sudo apt install xdg-utils curl nodejs-legacy npm
    sudo npm -g install instant-markdown-d


# mac
To make solrized work you need to install it for the terminal by `clone https://github.com/tomislav/osx-terminal.app-colors-solarized` then go to terminal preference and import the .terminal file. 

### Install YCM on mac 

1. Install homebrew and use it to install maVim and vim [link](http://stackoverflow.com/questions/21012203/how-can-i-install-macvim-on-os-x)
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
export PATH=/usr/local/bin:$PATH
brew update
brew install vim && brew install macvim
brew link macvim
brew linkapps
```
2. Install cmake and YCM
```sh
brew install cmake
cp  ~/dotfiles/extraConfig/ycm_extra_conf.py to ~/.vim
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

