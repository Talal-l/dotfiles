# Extra steps needed to make the vimrc work on Linux and Mac

# Both

Create a backup directory
```sh
mkdir ~/.vim/backups
```

Install Vundle 

`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`


## Linux

### YCM dependencies 

Make sure you have Python headers installed: 
```sh
sudo apt-get install python-dev python3-dev
```

Install development tools, cmake and compile YCM: 
```sh
sudo apt-get install build-essential cmake

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

### Additional component for Instant markdown preview 
     
 ```sh
sudo apt install xdg-utils curl nodejs-legacy npm
sudo npm -g install instant-markdown-d
```


## Mac

### YCM dependencies 

Install homebrew and use it to install macVim and the latest vim [link](http://stackoverflow.com/questions/21012203/how-can-i-install-macvim-on-os-x) by running the following:
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
export PATH=/usr/local/bin:$PATH
brew update
brew install vim && brew install macvim
brew link macvim
brew linkapps
```
Install cmake and YCM
```sh
brew install cmake
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

If you want to launch macVim from spotlight then find `MacVim.app` under `/usr/local/Cellar/macvim/` and copy it to the application directory


### Markdown tools 

```sh
brew install pandoc
```
