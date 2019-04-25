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

" Environment handling
Plug 'tpope/vim-dotenv'

" Git
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'sirver/ultisnips', { 'for': 'go' }

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
" if has('nvim')
"  Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" else
"   Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
" endif

" Python
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Sensible defaults ++
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'

" File navigation / search
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

" Themes
Plug 'morhetz/gruvbox'

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'

" Linting
Plug 'w0rp/ale'
" Plug 'scrooloose/syntastic'

" Comments
Plug 'scrooloose/nerdcommenter'

" Bracket pairing
Plug 'jiangmiao/auto-pairs'
Plug 'shougo/neopairs.vim'

" JavaScript and jsx
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
Plug 'galooshi/vim-import-js', { 'for': ['javascript', 'javascript.jsx', 'jsx']  }

" YAML formatting (faster)
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }

" tmux integration/navigation (and fix gocode, just because this is the last
" entry)
Plug 'christoomey/vim-tmux-navigator', { 'do': '~/utils/fix-gocode' }

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
set noshowmode
set cursorline

" Mouse integration
set mouse=a

" Clipboard
set clipboard^=unnamed
set clipboard^=unnamedplus

" Tab settings
set expandtab     " Expand tabs to the proper type and size
set tabstop=2     " Tabs width in spaces
set softtabstop=2 " Soft tab width in spaces
set shiftwidth=2  " Amount of spaces when shifting

" General shortcuts / overrides
noremap <C-c> :noh<CR>

" Leader shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>.e :vsplit ~/.vimrc<CR>
nnoremap <leader>.s :source ~/.vimrc<CR>

" Go Specific shortcuts
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>i <Plug>(go-imports)
au FileType go nmap <leader>h :GoSameIdsToggle<CR>
" au FileType go nmap <leader>p :GoVet<CR>
au FileType go noremap <C-s> :GoDeclsDir<CR>

" JS specific shortcuts
au FileType javascript map <C-]> :ALEGoToDefinition<CR>
au FileType javascript nmap <leader>p :ALEFix<CR>

" Navigation shortcuts
noremap <C-a> :NERDTreeToggle<CR>
noremap <C-o> :CtrlP<CR>
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
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_use_caching = 0 
let g:ctrlp_root_markers = ['.ctrlp']

" use ag when available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Golang
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_list_type = "quickfix"
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
" let g:go_statusline_duration = 10000
let g:go_metalinter_autosave = 0 
let g:go_auto_type_info = 1
let g:go_term_mode = "split"
let g:go_term_height = 13
let g:go_def_mode = 'godef'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Autocomplete
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 0
set completeopt-=preview
set completeopt+=noinsert
call deoplete#custom#source('_', 'converters', ['converter_auto_paren'])

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-j>" : "\<TAB>"

" Linting: ALE
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

" Emmet
let g:user_emmet_settings={'javascript.jsx': {'extends':'jsx'}, 'javascript': {'extends':'jsx'}}
let g:jsx_ext_required = 0

" Linting: Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

" Colors
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:airline_theme='gruvbox'

colorscheme gruvbox
