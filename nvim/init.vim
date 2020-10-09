" vim-plug{{{

call plug#begin(stdpath('data'))

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'kovisoft/slimv'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'turbio/bracey.vim'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'clktmr/vim-gdscript3'

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
nnoremap <SPACE> <Nop>

"utilSnips mapping
let g:UltiSnipsExpandTrigger="<C-f>"

nnoremap <leader>v :tabedit $MYVIMRC<CR>

"ale mappings
nnoremap <leader>e :ALENextWrap<CR>
nnoremap <leader>E :ALEPreviousWrap<CR>
nnoremap <leader>r :ALEPreviousWrap<CR>
map <leader>f <Plug>(ale_fix)

"extra scrol mapping
map <C-j> <C-E>
map <C-k> <C-Y>

"nerd commenter mappings 
map gc <Plug>NERDCommenterToggle

"search and replace current word 
"nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"remove search highlighting for current search
nmap <C-h> :noh<CR>

" }}}
" style and formating {{{

set background=dark
let darkeScheme = "jellybeans" 
let lightScheme = "PaperColor"
execute "colorscheme " . darkeScheme 


if has('mac')
    "colorscheme PaperColor
    "set background=light
else
endif

"number of visual spaces per TAB
set tabstop=4
"number of space in tab when editing
set softtabstop=4
"tabs are spaces
set expandtab
"indent 4 spaces instead of eight
set shiftwidth=4

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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" utilsnips config
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" ctrlp config 
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|^.git$\'



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


" workaround to fix background color when using vim in kitty terminal
let &t_ut=''

" }}}
" auto commands {{{

augroup vimrc
    autocmd!
    "Disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    "Set spell and hard wrapping for md files
    autocmd FileType markdown setlocal spell tw=80

    "source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC

    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

    "rename tmux window with the name of currently opened file
    autocmd FocusGained * call SetTmuxTerminalTitle(expand("%:p"). " [vim]")   
    autocmd BufEnter * call SetTmuxTerminalTitle(expand("%:p") . " [vim]")   


  
augroup END

" }}}

" vim:foldmethod=marker
