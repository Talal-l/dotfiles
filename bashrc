# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# useful aliases
alias f='find . -iname'

function mkdircd
{
    command mkdir "$1" && cd "$1"
}



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# fast way to copy to clipboard without mouse 
alias clip='xclip -sel clip'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# add a script directory 
export PATH="$HOME/dotfiles/bin:$PATH"

# add pip3 packages to path
if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi


# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# enable git bash completion on mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
fi

alias venv='source .venv/bin/activate'
alias vi='nvim --noplugin -u NONE'
alias vim='nvim'
alias vimdiff='nvim -d'
alias fd=fdfind

# set terminal title on start
PS1="\[\e]0;\w\a\]$PS1"

# update terminal title to reflect running program. Used for arbtt
trap 'echo -ne "\033]0;$(pwd) [$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g")]\007"' DEBUG

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#source <(kitty + complete setup bash)

# remaps

# remap CAP to Ctrl
setxkbmap -layout us -option ctrl:nocaps


# Fzf config


# apt didn't trigger the bash setup for fzf
source ~/dotfiles/extra_config/completion.bash
source ~/dotfiles/extra_config/key-bindings.bash

export FZF_DEFAULT_COMMAND='fdfind'

# from https://vi.stackexchange.com/a/26358
vit()
{
  if [[ ! -z "$VIM_TERMINAL" ]]; then
    if [ $# -eq 0 ]; then
      echo "You are already inside Vim. Provide filenames as arguments"
    else
      readlink -f $@ | xargs printf '\033]51;["call", "Tapi_vit", ["%s"]]\007'
    fi
  else
    vim $@
  fi
}

alias vim=vit




[ -f "/home/xanthr/.ghcup/env" ] && source "/home/xanthr/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

alias server="python3 -m http.server"

# added by pipx (https://github.com/pipxproject/pipx)
export PATH="/home/t__t/.local/bin:$PATH"
export PATH="/opt/lazygit/:$PATH"
source /opt/git-subrepo/.rc


export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:~/.local/bin 
PATH=$PATH:~/.local/bin

export PATH=$PATH:/opt/blender
export PATH=$PATH:/opt/whitebox



# pnpm
export PNPM_HOME="/home/t__t/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

eval "$(starship init bash)"

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.3.1/gems/vagrant-2.3.1/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)

export DENO_INSTALL="/home/t__t/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


