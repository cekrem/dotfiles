" Plugins
call plug#begin()
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Sensible defaults
Plug 'tpope/vim-sensible'

" File navigation
Plug 'scrooloose/nerdtree'

" Remote integration
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Appearance
Plug 'micha/vim-colors-solarized'
Plug 'vim-airline/vim-airline'

" Autocomplete
Plug 'Shougo/deoplete.nvim'

" Linting
Plug 'w0rp/ale'

" Syntax highlight for javascript and jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" Airline
let g:airline_powerline_fonts = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1

" Linting
let g:ale_fixers = {
  \ 'javascript': ['prettier']
  \ }
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0

" Colors
set background=dark
colorscheme solarized

" Nerdtree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-b> :NERDTreeToggle<CR>
