set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-latex/vim-latex'
"Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'rdnetto/YCM-Generator'
Plugin 'suan/vim-instant-markdown'
"Plugin 'gabrielelana/vim-markdown'
"Plugin 'nelstrom/vim-markdown-folding'
Plugin 'godlygeek/tabular'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax' 
Plugin 'jceb/vim-orgmode'
Plugin 'scrooloose/nerdtree'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Optional:
Plugin 'honza/vim-snippets'


Plugin 'NLKNguyen/papercolor-theme'
Plugin 'dracula/vim'

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

"YCM config
let g:ycm_global_ycm_extra_conf = '~/dotfiles/extra_config/ycm_extra_conf.py'

"To use grip for markdown preview
let vim_markdown_preview_github=1

"To enable folding for markdown
"let g:markdown_enable_folding = 1 "It makes vim very slow

"Disable vim-instant-markdown auto preview 
let g:instant_markdown_autostart = 0
" C-p will launch vim-instant-markdown
map <C-p> :InstantMarkdownPreview <CR>
"Enable folding by syntax
set foldmethod=syntax
"Fold based on indentation
set foldmethod=indent
"Don't break words with while wrapping  
set linebreak
"Share clipboard with other windows (not working on mac sierra inside tmux)
if $TMUX == ''
        set clipboard+=unnamed
    endif
"Show line number
set number 
"number of visual spaces per TAB
set tabstop=4 
"number of space in tab when editing
set softtabstop=4 
"tabs are spaces
set expandtab 
"set the runtime path to include Vundle and initialize
"indent 4 spaces instead of eight
set shiftwidth=4 
"keep 50 lines of command line history
set history=500		
"show the cursor position all the time
set ruler		    
"display incomplete commands
set showcmd		    
"do incremental searching
set incsearch		
syntax enable
set background=light
colorscheme PaperColor
"colorscheme solarized
"color dracula

"colorscheme default 
set autoindent

set backup
set swapfile
"save undo's after file closes
set undofile 
"how many undo's to save 
set undolevels=1000
"move swap and backup to VimBackup
set undodir=~/.vim/backups//
set backupdir=~/.vim/backups//
set directory =~/.vim/backups//

"encryption
set cm=blowfish2
set viminfo=

"spelling
set spelllang=en_us
map <F8> :setlocal spell!<CR>

"Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"show the limit for line length
"set colorcolumn=130

"compile
nnoremap <F5> :!g++ -g % -o ./bin/%:r<CR> 

"compile md to latex
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>

"run
nnoremap <F6> :!./bin/%:r<CR>

"Run python3 code
nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

"md to pdf
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>

"replace ecp with jk in insert mode 
inoremap jk <esc>

"to prevent clash with youcompleteme, change snippet trigger
imap <C-f> <Plug>snipMateNextOrTrigger
smap <C-f> <Plug>snipMateNextOrTrigger

"shortcut for nerdtree
map <C-n> :NERDTreeToggle<CR>

"vim powerline
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

"Always show statusline
"set laststatus=2

"Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
"set term=xterm-256color

"allow backspacing over everything in insert mode
set backspace=indent,eol,start


"Don't use Ex mode, use Q for formatting
map Q gq

"CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
"so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

