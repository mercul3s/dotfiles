"
" Vim plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Go tools
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'roxma/nvim-yarp'

" Additional colour schemes
Plug 'flazz/vim-colorschemes'
Plug 'nanotech/jellybeans.vim'

" General helpers 
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-surround'
Plug 'emilyst/vim-xray'
Plug 'vim-scripts/auto-pairs-gentle'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Markdown
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'gabrielelana/vim-markdown'

" NERDTree directory tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Nerdcommenter for block comments
" see :help nerdcommenter for usage
Plug 'scrooloose/nerdcommenter'

" Visual indentation tool
" Usage:
" <Leader>ig
" :IndentGuidesEnable
" :IndentGuidesDisable
" :IndentGuidesToggle
Plug 'nathanaelkane/vim-indent-guides'

" Terraform
Plug 'hashivim/vim-terraform'

" Yaml
Plug 'mrk21/yaml-vim'

" Arduino
Plug 'sudar/vim-arduino-syntax'

" Snippets for Vim
" https://github.com/SirVer/ultisnips
Plug 'SirVer/ultisnips'

" End plugins
call plug#end()

"
" Color scheme

" theme
colorscheme jellybeans
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

augroup vimrcEx
  autocmd!

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap git commit messages at 72 characters
  autocmd FileType gitcommit setlocal textwidth=72
augroup END

autocmd StdinReadPre * let s:std_in=1

" NERDTree autoload and always show hidden files/directories
autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

set autoindent
set smarttab
set autowrite

" resize splits automatically when window is resized
autocmd VimResized * wincmd =
"
" Key mappings

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"
" Mouse copy support
if has('mouse')
  set mouse=a
endif

" Xray config for showing whitespace chars
let g:xray_enable = 1
let g:xray_ignored_filetypes = ['nerdtree']
let g:xray_space_char = '·'
let g:xray_tab_chars = '> '
let g:xray_eol_char = '¶'
let g:xray_trail_char = '·'

" Visual indent on start
" let g:indent_guides_enable_on_vim_startup = 1

let mapleader = "-"

" Select word under cursor
noremap <space> viw

" Move line up or down by one
noremap <leader>_ dd2kp
noremap <leader>- ddp

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
iabbrev iferr if err!= nil {}

"
" Style
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5
au BufWinEnter * set number

" Use one space, not two, after punctuation.
set nojoinspaces

" Disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"
" Completions

set completeopt+=noinsert
set completeopt+=noselect

"
" Go Syntax
let g:go_list_type = "quickfix"
let g:go_fmt_command ="goimports"
let g:go_metalinter_autosave=1
let g:deoplete#enable_at_startup = 1

"
filetype on
filetype indent on
filetype plugin on
set sw=4
set ts=4

" use % when do block is highlighted to go to the end of the block (match do/end)
runtime macros/matchit.vim

" Yaml syntax
syntax on
filetype plugin indent on

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
