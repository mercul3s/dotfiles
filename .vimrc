"
" Plugins
call plug#begin('~/.vim/plugged')

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Additional colour schemes
Plug 'flazz/vim-colorschemes'
Plug 'nanotech/jellybeans.vim'

" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Mdkir
Plug 'pbrisbin/vim-mkdir'

" Markdown
Plug 'gabrielelana/vim-markdown'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" NERDTree directory tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

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

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END

NERDTreeToggle
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

"
" Key mappings

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"
" Competions

set completeopt+=noinsert
set completeopt+=noselect

" Deoplete (not working so commented out)
"  let g:deoplete#enable_at_startup = 1
"  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
"  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
"  let g:deoplete#sources#go#use_cache = 1
"  let g:deoplete#sources#go#json_directory = '/path/to/data_dir'

"
" Go Syntax

let g:go_list_type = "quickfix"
let g:go_fmt_command ="goimports"

" Yaml syntax
syntax on
filetype plugin indent on

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
