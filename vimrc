" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" switch background color between insert/normal mode (TODO)
" au InsertEnter * hi Normal ctermfg=188 ctermbg=8 guibg=#000000
" au InsertLeave * hi Normal ctermfg=188 ctermbg=236 guibg=#000000

" clear highliting of CursorLine
hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END
" set highlighting for CursorLineNR (line numbers)
hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

" " clear highliting of CursorLine
" hi clear CursorLine
" augroup CLClear
"     autocmd! ColorScheme * hi clear CursorLine
" augroup END
" " set highlighting for CursorLineNR (line numbers)
" hi CursorLineNR cterm=bold
" augroup CLNRSet
"     autocmd! ColorScheme * hi CursorLineNR cterm=bold
" augroup END

" set cmd window heigth, to solve 2x <CR> problems
":set cmdheight=2

" make cursor visible with line
set cursorline

" set nocp
:filetype plugin on
:syntax on

" allow switching buffer event it's not saved.
set hidden
"set confirm

" define own foldtext, which to remove the line count
function! MyfoldText()
	let txt = '+' . substitute(getline(v:foldstart),"^ *", "", 1)
	return txt
endfunction
set foldtext=MyfoldText()
set foldmethod=syntax
" open all folds after reading a buffer (does not work)
"au BufRead * normal zR	
autocmd Syntax * normal zR

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" autoopen tagbar
autocmd BufEnter c,cpp nested :call tagbar#autoopen(0)

" open manpages inside vim
runtime! ftplugin/man.vim
" and use SHIFT-K with it instead of vim buildin man viewer
nmap K :Man <cword><CR>

" enable doxygen highlights
let g:load_doxygen_syntax=1

" fix CTRL-Cursor in 'insert mode'
" enter ':map ' + STRG-V + STRG-Left + '<C-Left>
:map Oc <C-Right>
:map Od <C-Left>
:map Oa <C-Up>
:map Ob <C-Down>

" move between windows with ALT-CURSOR
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Up> :wincmd j<CR>
nmap <silent> <A-Down> :wincmd k<CR>
nmap <silent> <A-Right> :wincmd l<CR>

let mapleader=","
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" disable pylint for python mode
let mapleader=","
let g:pymode_lint=0
let g:pymode_rope=0

" activate mouse cursor mode
" was "ar", removed "a" to get gpm copy working from terminel to vim
:set mouse=r mousemodel=extend

" avoid 2s timout on leaving INSERT mode via ESC
set timeout " Do time out on mappings and others
set timeoutlen=2000 " Wait {num} ms before timing out a mapping

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" mark TAB with underlines (does not work in textmode ?!?!)
" syntax match Tab /\t/
" hi Tab gui=underline guifg=blue ctermbg=blue 

set expandtab	" insert SPACE instead of TAB
set autoindent	" newline shall match indent of previous
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
"set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
" ignroe following file prefixes on load ...
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile

set term=xterm-256color
"colorschemes 
"solarized - matt, airline git not readable
"wombat - darb bg, color
"bubblegum - matt
"moria - black bg, colorfull
"twilight - matt
"distinguished - matt, not so colorfull
"zenburn - sehr matt
"lucius
"codeschool
colorscheme lucius
set background=dark

" mark line nr of current line
hi clear CursorLine
hi CursorLineNR ctermbg=green ctermfg=black

" always enable status bar
set laststatus=2
" enable enhanced airline tabbar
let g:airline#extensions#tabline#enabled=1

map <C-n> :cn<CR>
map <C-p> :cp<CR>

" map NERDTree to F2
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
" toggle tcomment
map _ : TComment<CR>
" Tagbar
nmap <F8> :TagbarToggle<CR>
" switcher.vim toggle command
nnoremap - :Switch<cr>
" regenerate ctags
map <C-F12> :!ctags -R .<CR>

" mapping for tabs
"nmap <c-t> :tabnew <cr>
"nmap <a-right> :tabnext <cr>
"nmap <a-left> :tabprevious <cr>
"nmap <c-w> :tabclose <cr>
nmap <s-right> :bnext <cr>
nmap <s-left> :bprev <cr>

" map S-Enter to insert empy lines
nmap <S-Enter> O<Esc>

" disable search highlight by hiting ESC
noremap <silent><esc> <esc>:noh<CR><esc>
" map search word below cursor in files
noremap + :grep! -rI --exclude=tags --exclude-dir="\.git" <cword> *<cr>
"search for word below cursor and replace
nnoremap <C-h> :%s/\<<C-r><C-w>\>/

" auto reload vimrc if changed within vim
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" jump to last location in file on open
"if has("autocmd")
"	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"endif

" add a vertical line at 80 coloumn
":set cc=80
":hi ColorColumn ctermbg=lightblue uibg=lightblue

" Use completion for these filetypes only
let g:ycm_filetype_whitelist = {
     \ 'c': 1,
     \ 'cpp': 1,
	\ }
"     \ 'python': 1,
"	 \ }

" add tab number and window number to tabbar
" if has('gui')
"   set guioptions-=e
" endif
" if exists("+showtabline")
"   function! MyTabLine()
"     let s = ''
"     let t = tabpagenr()
"     let i = 1
"     while i <= tabpagenr('$')
"       let buflist = tabpagebuflist(i)
"       let winnr = tabpagewinnr(i)
"       let s .= '%' . i . 'T'
"       let s .= (i == t ? '%1*' : '%2*')
"       let s .= ' '
"       let s .= i . ':'
"       let s .= winnr . '/' . tabpagewinnr(i,'$')
"       let s .= ' %*'
"       let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"       let bufnr = buflist[winnr - 1]
"       let file = bufname(bufnr)
"       let buftype = getbufvar(bufnr, 'buftype')
"       if buftype == 'nofile'
"         if file =~ '\/.'
"           let file = substitute(file, '.*\/\ze.', '', '')
"         endif
"       else
"         let file = fnamemodify(file, ':p:t')
"       endif
"       if file == ''
"         let file = '[No Name]'
"       endif
"       let s .= file
"       let i = i + 1
"     endwhile
"     let s .= '%T%#TabLineFill#%='
"     let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
"     return s
"   endfunction
"   set stal=2
"   set tabline=%!MyTabLine()
"   map    <C-Tab>    :tabnext<CR>
"   imap   <C-Tab>    <C-O>:tabnext<CR>
"   map    <C-S-Tab>  :tabprev<CR>
"   imap   <C-S-Tab>  <C-O>:tabprev<CR>
" endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for vundle
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" vundle for YCM
" Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'klen/python-mode'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'tcomment'
Plugin 'switch.vim'

filetype plugin indent on     " required!
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line
