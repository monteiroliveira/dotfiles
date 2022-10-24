call plug#begin()
Plug 'preservim/nerdtree' " File explorer
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'dag/vim-fish'
call plug#end()

" Setters
set nu relativenumber 
set encoding=UTF-8
set incsearch
set wildmenu
set laststatus=2
set mouse=a
set ttimeoutlen=50
set termguicolors
set tabstop=4
"set clipboard=unnamedplus       " Copy/paste between vim and other programs.
syntax on

"set background=dark
colorscheme onehalfdark

nnoremap <SPACE> <Nop>
let mapleader=" "

" Maps
map <leader>qq :quit<CR>
map <leader>w :write<CR>
	" Change window shortcuts
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Airlines configs
let g:airline_powerline_fonts=1
let g:airline_theme = 'violet'

" Vim Hexokinase
	" Vim default
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
