" Plugins
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'micha/vim-colors-solarized'
"Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
call plug#end()

" Autocomplete
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1

" Linting
let g:ale_fixers = {
  \ 'javascript': ['prettier']
  \ }

" Colors
set background=dark
colorscheme solarized

" Nerdtree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-b> :NERDTreeToggle<CR>
