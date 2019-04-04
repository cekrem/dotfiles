" Plugins
call plug#begin()
" Autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'mattn/emmet-vim'

" Git
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'sirver/ultisnips'

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
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim'

" Themes
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'

" Linting ALE DISABLED FOR NOW
"Plug 'w0rp/ale'

" Comments
Plug 'scrooloose/nerdcommenter'

" Bracket pairing
Plug 'jiangmiao/auto-pairs'
Plug 'shougo/neopairs.vim'

" JavaScript and jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'galooshi/vim-import-js'

" YAML formatting (faster)
Plug 'stephpy/vim-yaml'

call plug#end()

" General settings
set hidden
set number
set autoread
set autowrite
set noswapfile
set ignorecase
set smartcase
set splitright
set splitbelow

" Clipboard
set clipboard^=unnamed
set clipboard^=unnamedplus

" Tab settings
set expandtab     " Expand tabs to the proper type and size
set tabstop=2     " Tabs width in spaces
set softtabstop=2 " Soft tab width in spaces
set shiftwidth=2  " Amount of spaces when shifting

" Leader shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>.e :vsplit ~/.vimrc<cr>
nnoremap <leader>.s :source ~/.vimrc<cr>
nmap <leader>p :ALEFix<CR>

" Go Specific shortcuts
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>i <Plug>(go-imports)
au FileType go nmap <leader>p <Plug>(go-lint)
au FileType go noremap <C-s> :GoDeclsDir<CR>

" Js specific shortcuts
au FileType javascript map <C-]> :ALEGoToDefinition<CR>

" Navigation shortcuts
noremap <C-a> :NERDTreeToggle<CR>
noremap <C-o> :CtrlP<CR>
noremap <C-j> :bnext<CR>
noremap <C-k> :bprev<CR>
nnoremap <C-\> :call NERDComment(0,"toggle")<CR>
vnoremap <C-\> :call NERDComment(0,"toggle")<CR>
inoremap <C-\> <C-o>:call NERDComment(0,"append")<CR>

" Git shortcuts
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
" Undo hunk: <leader>hu
" Stage hunk: <leader>hs

" CtrlP tweaks
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
let g:ctrlp_cmd = 'CtrlPBuffer'

" Golang
let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
let g:go_list_type = "quickfix"
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_statusline_duration = 10000
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet']
let g:go_metalinter_deadline = "10s"
let g:go_auto_type_info = 1
let g:go_term_mode = "split"
let g:go_term_height = 13
let g:go_def_mode = 'godef'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 1
set completeopt-=preview
set completeopt+=noinsert
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Linting
let g:ale_linters = {
  \ 'go': [],
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
let g:fix_on_save = 1

" Colors
set background=dark
set termguicolors
let g:airline_theme='minimalist'

if strftime("%H") < 17
  "colorscheme onedark
  colorscheme NeoSolarized
else
  colorscheme gruvbox
endif
