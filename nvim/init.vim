" vim-plug{{{

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(stdpath('data'))

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'turbio/bracey.vim'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'clktmr/vim-gdscript3'
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'kovisoft/paredit'
Plug 'kamykn/CCSpellCheck.vim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'skanehira/vsession'
Plug 'gcmt/taboo.vim'
Plug '~/.local/share/nvim/site/plugin/whitebox.vim'
Plug '~/.local/share/nvim/site/plugin/scriptnames.vim'
Plug 'rust-lang/rust.vim'
Plug 'pearofducks/ansible-vim'
Plug 'yaegassy/coc-ansible', {'do': 'npm install'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dotenv'
Plug 'kristijanhusak/vim-dadbod-ui'

"
call plug#end()
" }}}

" functions {{{

"override the terminal title if vim messes up
" https://github.com/MikeDacre/tmux-zsh-vim-titles/blob/master/plugin/unified-titles.vim
function! SetTmuxTerminalTitle(titleString)
  "let cmd2 = 'silent !setTitleEnd '. a:titleString
  let cmd1 = 'silent !echo -ne "\033]0;' . a:titleString . '\007"'
  execute cmd1

  redraw!
endfunction
" }}}
" writing aid {{{

"spelling
set spelllang=en_us
map <F7> :setlocal spell!<CR>


" }}}
"general maps {{{

"compile md to latex
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>
"run
nnoremap <F6> :!./bin/%:r<CR>
"md to pdf
nnoremap <F2> :!pandoc % -o %:r.pdf<CR><CR>
"replace ecp with jk in insert mode
inoremap jk <esc>
"shortcut for nerdtree
map <C-n> :NERDTreeToggle<CR>
"escape qoutes in insert mode
inoremap <C-e> <C-o>A 
"move back 1 step (used to renter brackets)
inoremap <C-k> <C-o>i 

"set leader key
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <SPACE> <Nop>

"utilSnips mapping
let g:UltiSnipsExpandTrigger="<C-f>"

" vim config shortcuts
nnoremap <leader>v :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


" Fix broken highlish syntax
noremap <F9> <Esc>:syntax sync fromstart<CR>
inoremap <F9> <C-o>:syntax sync fromstart<CR>

" vim-fugitive'
nnoremap <leader>g :vertical leftabove 30G<CR>

nnoremap <leader>sv :source $MYVIMRC<CR>

" switch between current and last buffer
nmap <leader><SPACE> <c-^>

"nerd commenter mappings 

let g:NERDCreateDefaultMappings = 0
map gc <Plug>NERDCommenterToggle

"search and replace current word 
"nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"remove search highlighting for current search
nmap <C-h> :noh<CR>

" }}}
" style and formating {{{

set background=dark
let darkeScheme = "iceberg" 
let lightScheme = "iceberg"
execute "colorscheme " . darkeScheme 


if has('mac')
    "colorscheme PaperColor
    "set background=light
else
endif

"show whitechar
set lcs=tab:>-,eol:¬,nbsp:%,space:.,tab:▸\

set list
"number of visual spaces per TAB
set tabstop=4
"number of space in tab when editing
set softtabstop=4
"tabs are spaces
set expandtab
"indent 2 spaces instead of eight
set shiftwidth=2

set autoindent
"set textwidth=79

map <F8> :call ToggleLight()<CR>

set t_Co=256
"Don't break words while wrapping
"set linebreak
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

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! ToggleLight()
    if &background == "dark"
        set background=light
        execute "colorscheme " . g:lightScheme
    else
        set background=dark 
        execute "colorscheme " . g:darkeScheme 
    endif

endfunc
    


" }}}
" plugins config {{{

"COC config

let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }
let g:CCSpellCheckMatchGroupName = 'CCSpellBad'
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Override highlight setting.
highlight CCSpellBad cterm=reverse ctermfg=magenta gui=reverse guifg=magenta


command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')


" Formatting selected code.
xmap <leader>f  <Plug>(coc-format)
nmap <leader>f  <Plug>(coc-format)


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" utilsnips config
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" Fzf config 

if isdirectory(".git")
    nmap <silent> <C-p> :GFiles<CR>
    nmap <silent> <C-P> :Files<CR>
else
    nmap <silent> <C-p> :Files<CR>
endif

nnoremap <silent> <C-l> :BLines<CR>
nnoremap <silent> <c-space> :Buffers<CR>


noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>


set sessionoptions+=tabpages,globals

" coc-fzf
nnoremap <silent> <leader>cl       :<C-u>CocFzfList<CR>
nnoremap <silent> <leader>cD       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <leader>cd       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <leader>cc       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <leader>ce       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <leader>cL       :<C-u>CocFzfList location<CR>
nnoremap <silent> <leader>co       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <leader>cs       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <leader>cp       :<C-u>CocFzfListResume<CR>


" }}}
" misc {{{

set nocompatible
filetype plugin on

"fold based on indentation
set foldmethod=indent

" reduce update time for githutter
set updatetime=100

"share clipboard with other windows (not working on mac sierra inside tmux)

if has("unix")
    let s:uname = substitute(system("uname -s"), '\n', '', '')

    if s:uname == "Darwin"
        "rnnning under mac
        " set correct YCM  path under mac
        let g:ycm_server_python_interpreter="/usr/local/bin/python3"
        if $TMUX == ''
            set clipboard+=unnamed
        endif
    elseif s:uname == "Linux"
        " set correct YCM  path under linux
        let g:ycm_server_python_interpreter = '/usr/bin/python3'
        set clipboard+=unnamed
    endif
endif

if $TMUX == ''
    set clipboard+=unnamed
endif

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has('mouse')
    set mouse=a
endif

syntax enable

"do incremental searching
set incsearch

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

let g:netrw_dirhistmax=0

" workaround to fix background color when using vim in kitty terminal
let &t_ut=''

" better default split locations
set splitbelow
set splitright

" TODO: make this work with all quit options like qw 
" declare function for moving left when closing a tab.
function! TabCloseLeft(cmd)
    if winnr('$') == 1 && tabpagenr('$') > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr('$')
        exec a:cmd | tabprevious
    else
        exec a:cmd
    endif
endfunction






" }}}
" auto commands {{{

augroup vimrc
    autocmd!
    "Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    "Set spell and hard wrapping for md files

    "source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC

    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

    "rename tmux window with the name of currently opened file
    autocmd FocusGained * call SetTmuxTerminalTitle(expand("%:p"). " [vim]")   
    autocmd BufEnter * call SetTmuxTerminalTitle(expand("%:p") . " [vim]")   

    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au FileType fzf tunmap <buffer> <Esc>

  
augroup END

" }}}

" auto commands {{{
" terminal emulator
"""""""""""""""
  nnoremap <leader>t :belowright 10split term://bash <CR>
  nnoremap <leader>T :belowright vsplit term://bash <CR>
  nnoremap <C-j> :echo "test"<CR>
  tmap <C-j> :echo "test"<CR>


  "tnoremap <C-j> <C-w>j
  "tnoremap <C-k> <C-w>k
  "tnoremap <C-h> <C-w>h
  "tnoremap <C-l> <C-w>l
  tnoremap <C-J> <C-W><C-J>
  tnoremap <C-K> <C-W><C-K>
  tnoremap <C-L> <C-W><C-L>
  tnoremap <C-H> <C-W><C-H>


" }}}

" functions {{{
" used to open files in vim when using vim terminal
function! Tapi_vit(bufnum, arglist)
   let currfile = get(a:arglist, 0, '')
   let $VIM_TERMINAL = "yes"
   if empty(currfile)
     return
   endif
   execute 'e' currfile
endfunction



" from https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
" delet buffers using fzf
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]} ))
endfunction



command! Bd call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))



"}}}

" vim:foldmethod=marker
