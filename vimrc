" vundle {{{
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'dracula/vim'
Plugin 'tpope/vim-surround'
Plugin 'othree/xml.vim'
Plugin 'w0rp/ale'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline'

"The following are examples of different formats supported.
"Keep Plugin commands between vundle#begin/end.
"plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"The sparkup vim script is in a subdirectory of this repo called vim.
"Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Install L9 and avoid a Naming conflict if you've already installed a
"different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"Brief help
":PluginList       - lists configured plugins
":PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
":PluginSearch foo - searches for foo; append `!` to refresh local cache
":PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
"see :h vundle for more details or wiki for FAQ
"Put your non-Plugin stuff after this line
" }}}
" folding {{{

"Fold based on indentation
set foldmethod=indent

" }}}
" backup {{{

set backup
set swapfile
"save undo's after file closes
set undofile 
"how many undo's to save 
set undolevels=1000
"keep 50 lines of command line history
set history=500		
"move swap and backup to VimBackup
set undodir=~/.vim/backups//
set backupdir=~/.vim/backups//
set directory =~/.vim/backups//

" }}}
" writing aid {{{

"spelling
set spelllang=en_us
map <F8> :setlocal spell!<CR>

" }}}
"general maps {{{

"show the limit for line length
"compile
nnoremap <F5> :!g++ -g % -o ./bin/%:r<CR> 
"compile md to latex
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>
"run
nnoremap <F6> :!./bin/%:r<CR>
"md to pdf
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>
"replace ecp with jk in insert mode 
inoremap jk <esc>
"to prevent clash with youcompleteme, change snippet trigger
imap <C-f> <Plug>snipMateNextOrTrigger
smap <C-f> <Plug>snipMateNextOrTrigger
imap <C-d> <Plug>snipMateBack
smap <C-d> <Plug>snipMateBack
"shortcut for nerdtree
map <C-n> :NERDTreeToggle<CR>

"set leader key 
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>
" }}}
" style and layout {{{

"colorscheme solarized
color dracula
if has('mac')
    "colorscheme PaperColor
    "set background=light
else
endif

set t_Co=256
"Don't break words while wrapping  
set linebreak
"column length indicator
set colorcolumn=80
"Show line number
set number 
"show the cursor position all the time
set ruler
"display incomplete commands
set showcmd

"show status line
set laststatus=2

" }}}
" privacy {{{

"encryption
set cm=blowfish2
set viminfo=

" }}}
" tab and spaces {{{

"number of visual spaces per TAB
set tabstop=4 
"number of space in tab when editing
set softtabstop=4 
"tabs are spaces
set expandtab 
"indent 4 spaces instead of eight
set shiftwidth=4

set autoindent
set textwidth=79

" }}}
" misc {{{

set nocompatible
filetype plugin on

"Share clipboard with other windows (not working on mac sierra inside tmux)

if has("unix")
    let s:uname = substitute(system("uname -s"), '\n', '', '')

    if s:uname == "Darwin"
        "Rnnning under mac
        if $TMUX == ''
            set clipboard+=unnamed
        endif
    elseif s:uname == "Linux"
            set clipboard+=unnamed
    endif
endif

if $TMUX == ''
        set clipboard+=unnamed
    endif

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"YCM config
let g:ycm_global_ycm_extra_conf = '~/dotfiles/extra_config/ycm_extra_conf.py'

syntax enable
"do incremental searching
set incsearch

" }}}
" auto commands {{{

"Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"Set spell and hard wrapping for md files
autocmd FileType markdown setlocal spell tw=80

" }}}
" python settings {{{

"Run python3 code
nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" }}}

" vim:foldmethod=marker
