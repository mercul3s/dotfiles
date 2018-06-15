"
" Plugins

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Autocomplete
Plug 'Shougo/deoplete.nvim'

" Neomake
Plug 'neomake/neomake'

" Go
Plug 'fatih/vim-go'
Plug 'nsf/gocode'
Plug 'zchee/deoplete-go', { 'do': 'make' }

" Control-P
Plug 'kien/ctrlp.vim'

" T-Comment
Plug 'tomtom/tcomment_vim'

" Additional colour schemes
Plug 'flazz/vim-colorschemes'

" Silver surfer
Plug 'mileszs/ack.vim'

" Mdkir
Plug 'pbrisbin/vim-mkdir'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'nanotech/jellybeans.vim'

" Initialize plugin system
call plug#end()

"
" Key mappings

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

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

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Search

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif


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

"
" Table Completion

" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Enable folding
"set foldmethod=syntax
"set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"
" Silver Surfer

" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
" endif

"
" Competions

set completeopt+=noinsert
set completeopt+=noselect

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '/path/to/data_dir'

"
" Go Syntax

let g:go_list_type = "quickfix"
let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=vet', '--enable=golint', '--enable=ineffassign', '--enable=goconst']
let g:go_fmt_command ="goimports"
autocmd! BufWritePost * Neomake

"
" Markdown

" let g:markdown_composer_external_renderer='pandoc -f markdown_github -t html'
