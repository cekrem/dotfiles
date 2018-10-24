" Plugins
call plug#begin()
" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Python
Plug 'zchee/deoplete-jedi'

" Sensible defaults ++
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'

" File navigation
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Remote integration
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Appearance
Plug 'micha/vim-colors-solarized'
Plug 'vim-airline/vim-airline'

" Linting
Plug 'w0rp/ale'

" Bracket pairing
Plug 'jiangmiao/auto-pairs'

" Syntax highlight for javascript and jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" General settings
set hidden
set number
set autoread
set noswapfile
set smartcase
set splitright
set splitbelow

" Tab settings
set expandtab     " Expand tabs to the proper type and size
set tabstop=2     " Tabs width in spaces
set softtabstop=2 " Soft tab width in spaces
set shiftwidth=2  " Amount of spaces when shifting

" Fast save and close
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>p :ALEFix<CR>

" Golang
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_list_type = "quickfix"
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_statusline_duration = 10000
let g:go_metalinter_autosave = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1

" Linting
let g:ale_linters = {
  \ 'go': ['gometalinter'],
  \ 'html': [],
  \ 'javascript': ['eslint', 'prettier', 'tsserver'],
  \ 'python': ['flake8'],
  \ 'ruby': ['brakeman', 'rails_best_pratices', 'rubocop']
  \ }
let g:ale_go_gometalinter_options = '
  \ --aggregate
  \ --disable=gas
  \ --disable=goconst
  \ --disable=vetshadow
  \ --fast
  \ --sort=line
  \ --tests
  \ --vendor
  \ '
let g:ale_fixers = {
  \ 'javascript': ['prettier']
  \ }
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

" Colors
set background=dark
colorscheme solarized

" File navigation config
let g:ctrlp_cmd = 'CtrlPMixed'
map <C-1> :NERDTreeToggle<CR>
