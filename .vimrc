" Basic settings
set nocompatible
set background=dark
     if has('win32') || has('win64')
       set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
     endif

cd ~

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'jonathanfilip/vim-lucius'
Bundle 'tpope/vim-surround'
Bundle 'davidhalter/jedi-vim'
Bundle 'nvie/vim-flake8'

Bundle 'TeX-PDF'

Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

set background=dark
syntax on
set mouse=a
scriptencoding utf-8

set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set nospell                       " spell checking on
set clipboard=unnamedplus

set noerrorbells
set novisualbell
set t_vb=

nmap <silent> <leader>s :set spell

set noswapfile
set backup

au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

colorscheme lucius

set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode

set cursorline                  " highlight current line
hi cursorline guibg=#333333     " highlight bg color of current line
hi CursorColumn guibg=#333333   " highlight cursor

if has('cmdline_info')
 set ruler                   " show the ruler
 set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
 set showcmd                 " show partial commands in status line and
                             " selected characters/lines in visual mode
endif

if has('statusline')
 set laststatus=2

 " Broken down into easily includeable segments
 set statusline=%<%f\    " Filename
 set statusline+=%w%h%m%r " Options
 set statusline+=\ [%{&ff}/%Y]            " filetype
 set statusline+=\ [%{getcwd()}]          " current dir
 set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
 set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " backspace for dummys
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high 
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present

" wildmenu
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set wildignore=*.o,*.exe,*.dll,*.swp,*.~cpp,*.~hpp,*.~h,*.obj,*.hi,*.exe,*.un~,*.class,*.d

set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set gdefault                    " the /g flag on :s substitutions by default
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
if !has('win32') && !has('win64')
    set guifont=Ubuntu\ Mono\ 11
else
    set guifont=consolas:h10
endif

 " Formatting
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set matchpairs+=<:>                " match, to be used with % 
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd FileType c,cpp set completefunc=ClangComplete
autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: iso-8859-15 -*-\<nl>\"|$

let mapleader = ','
nnoremap ; :

set concealcursor=inv
set conceallevel=2
set colorcolumn=80

" Easier moving in tabs and windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
map <C-K> <C-W>k

nnoremap <leader>( :tabprevious<cr>
nnoremap <leader>) :tabnext<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

nmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>yy "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" Split line (sister to [J]oin lines)
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"clearing highlighted search
nmap <silent> <leader>h :nohlsearch<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" Misc
:map <C-F10> <Esc>:vsp<CR>:VTree<CR>

noremap <leader><F5> :CheckSyntax<cr>
let g:checksyntax_auto = 1

let b:match_ignorecase = 1

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings 
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

" Fuzzy Finder
""" Fuzzy Find file, tree, buffer, line
nmap <leader>ff :FufFile **/<CR>
nmap <leader>ft :FufFile<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>fr :FufRenewCache<CR>

" clang_complete
let g_clang_complete_auto=1
let g:clang_auto_select=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_use_library=1
let g:clang_periodic_quickfix=1
let g:clang_complete_snippets=1
let g:clang_conceal_snippets=1
let g:clang_close_preview=1

let g:clang_library_path=$CLANG_LIB

if has('win32') || has('win64')
    let g:clang_user_options='-IC:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\include'
else
    let g:clang_user_options='-I/usr/include/c++/4.8'
endif

" check syntax
nmap <silent> <leader>Q :call g:ClangUpdateQuickFix()<cr>

if has('gui_running')
     set guioptions-=T           " remove the toolbar
     set guioptions-=m
     set guioptions-=r
     set guioptions-=L
     set lines=40                " 40 lines of text instead of 24,
else
    set term=screen-256color
endif

function! InitializeDirectories()
   let separator = "."
   let parent = $HOME 
   let prefix = '.vim'
   let dir_list = { 
               \ 'backup': 'backupdir', 
               \ 'views': 'viewdir', 
               \ 'swap': 'directory' }

   for [dirname, settingname] in items(dir_list)
       let directory = parent . '/' . prefix . dirname . "/"
       if exists("*mkdir")
           if !isdirectory(directory)
               call mkdir(directory)
           endif
       endif
       if !isdirectory(directory)
           echo "Warning: Unable to create backup directory: " . directory
           echo "Try: mkdir -p " . directory
       else  
           let directory = substitute(directory, " ", "\\\\ ", "")
           exec "set " . settingname . "=" . directory
       endif
   endfor
 endfunction
call InitializeDirectories() 

function! NERDTreeInitAsNeeded()
     redir => bufoutput
     buffers!
     redir END
     let idx = stridx(bufoutput, "NERD_tree")
     if idx > -1
         NERDTreeMirror
         NERDTreeFind
         wincmd l
     endif
 endfunction

" commands to setup settings for different file types
augroup fswitch
    autocmd!
    autocmd! BufEnter,BufRead *.h let b:fswitchdst = 'c,cpp'
                              \ | let b:fswitchlocs = '.'
    autocmd! BufEnter,BufRead *.c let b:fswitchdst = 'h'
                              \ | let b:fswitchlocs = '.'
    autocmd! BufEnter,BufRead *.hpp let b:fswitchdst = 'cpp'
                              \ | let b:fswitchlocs = '.'
    autocmd! BufEnter,BufRead *.cpp let b:fswitchdst = 'hpp,h'
                                \ | let b:fswitchlocs = '.'
augroup end

" switch to the file and load it into the current window
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <f5> :FSHere<cr>
imap <silent> <f5> <c-o>:FSHere<cr>

" in current window
nmap <silent> <Leader>oo :FSHere<cr>
" in a new tab
nmap <silent> <Leader>ot :call FSwitch('%', 'tabedit')<cr>

" switch to the file and load it into the window on the right
nmap <silent> <Leader>ol :FSRight<cr>

" switch to the file and load it into a new window split on the right
nmap <silent> <Leader>oL :FSSplitRight<cr>

" switch to the file and load it into the window on the left
nmap <silent> <Leader>oh :FSLeft<cr>

" switch to the file and load it into a new window split on the left
nmap <silent> <Leader>oH :FSSplitLeft<cr>

" switch to the file and load it into the window above
nmap <silent> <Leader>ok :FSAbove<cr>

" switch to the file and load it into a new window split above
nmap <silent> <Leader>oK :FSSplitAbove<cr>

" switch to the file and load it into the window below
nmap <silent> <Leader>oj :FSBelow<cr>

" switch to the file and load it into a new window split below
nmap <silent> <Leader>oJ :FSSplitBelow<cr>
