" Plugins
call plug#begin()
" Autocomplete
Plug 'mattn/emmet-vim'

" Environment handling
Plug 'tpope/vim-dotenv'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'sirver/ultisnips', { 'for': 'go' }

" Golang
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'goooo' }
Plug 'govim/govim'

" C#
"Plug 'OmniSharp/omnisharp-vim', { 'do': ':OmniSharpInstall', 'for': 'cs' }
"Plug 'tpope/vim-dispatch'

" Sensible defaults ++
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'

" File navigation / search
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' 

" Themes
Plug 'morhetz/gruvbox'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'

" Indent guides
Plug 'nathanaelkane/vim-indent-guides'

" Tagbar
Plug 'majutsushi/tagbar'

" Linting
Plug 'w0rp/ale'

" Comments
Plug 'scrooloose/nerdcommenter'

" Bracket pairing
Plug 'jiangmiao/auto-pairs'

" JavaScript and jsx
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
Plug 'galooshi/vim-import-js', { 'for': ['javascript', 'javascript.jsx', 'jsx'] } 

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" YAML formatting (faster)
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }

" HTTP requests
Plug 'nicwest/vim-http'

" SQL
Plug 'tpope/vim-dadbod'

" tmux integration/navigation
Plug 'christoomey/vim-tmux-navigator'

" StackOverflow
Plug 'mickaobrien/vim-stackoverflow'

" Super important stuff
Plug 'mattn/vim-starwars'

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

" Cursor styling
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" General shortcuts / overrides
noremap <silent> <C-c> :nohl<CR> :ccl<CR>
noremap <silent> <esc> :nohl<CR> :ccl<CR>
inoremap jk <esc>
inoremap JK <esc>
nnoremap <leader>* :%s/\<<C-r><C-w>\>//g<Left><Left>
set grepprg=rg\ --color=vimgrep

" Search
nnoremap <leader>a :Rg<CR>
nnoremap <leader>s :ALESymbolSearch<Space>
nnoremap <leader>fd :syn clear Repeat \| g/^\(.*\)\n\ze\%(.*\n\)*\1$/exe 'syn match Repeat "^' . escape(getline('.'), '".\^$*[]') . '$"' \| nohlsearch<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-j>" : "\<TAB>"

" Intellisense & linting shortcuts
noremap <C-]> :ALEGoToDefinition<CR>
nnoremap <leader>fr :ALEFindReferences<CR> 
nnoremap <leader>p :ALEFix<CR>
nnoremap <leader>v :ALEHover<CR>
nnoremap <leader>d :ALEDetail<CR>
nnoremap <silent> ]w :ALENext<cr>
nnoremap <silent> [w :ALEPrevious<cr>
nnoremap <silent> <leader>w :lopen<cr>

" DB shortcuts
au FileType sql nnoremap <leader>dbu :%DB $UAT_DB<CR>
au FileType sql nnoremap <leader>dbm :%DB $MT_DB<CR>
au FileType sql nnoremap <leader>dbp :%DB $PROD_DB<CR>
au FileType sql nnoremap <leader>dbd :%DB $DEV_DB<CR>

" Golang Specific shortcuts
"au FileType go nnoremap <buffer> <leader>r <Plug>(go-run)
"au FileType go nnoremap <buffer> <leader>i <Plug>(go-imports);
au FileType go nnoremap <buffer> <leader>h :GOVIMHighlightReferences<CR>
au FileType go nnoremap <buffer> <leader>fr :GOVIMReferences<CR>
au FileType go nnoremap <buffer> <leader>v :<C-u>call GOVIMHover()<CR>
au FileType go nnoremap <buffer> <leader>gr :GOVIMRename<CR>

" Bash script tab => spaces
au FileType sh set expandtab

" Navigation shortcuts
noremap <silent> <C-a> :NERDTreeToggle<CR>
nnoremap <C-\> :call NERDComment(0,"toggle")<CR>
vnoremap <C-\> :call NERDComment(0,"toggle")<CR>
inoremap <C-\> <C-o>:call NERDComment(0,"append")<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <leader>.e :vsplit ~/.vimrc<CR>
nnoremap <leader>.s :source ~/.vimrc<CR>

" Git shortcuts
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap <leader>gf :GitGutterFold<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>g* :Git sed 's/\<<C-r><C-w>\>//g'<Left><Left><Left>
" Undo hunk: <leader>hu
" Stage hunk: <leader>hs

" Fuzzy finding
let g:rooter_patterns = ['.ctrlp', '.gitignore', 'package.json', 'go.mod']
let g:rooter_silent_chdir = 1
noremap <C-p> :Files<CR>

" vim-go tweaks
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
let g:go_auto_type_info = 0
let g:go_term_mode = "split"
let g:go_term_height = 13
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" C# tweaks
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_stdio_quickload = 1
let g:OmniSharp_server_loading_timeout = 5
let g:OmniSharp_highlight_types = 2

" Statusline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
"let g:lightline.active = 'left': { [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ] }
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" Autocomplete
let g:ale_completion_enabled = 1
set completeopt-=preview
set completeopt+=noinsert

" Linting: ALE
let g:ale_cursor_detail = 0
let g:ale_close_preview_on_insert = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'scss': ['prettier'],
\   'python': ['yapf'],
\   'sql': ['pgformatter'],
\   'json': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'go': [],
\   'c': ['clang-format'],
\   'cs': ['uncrustify'],
\   'rust': 'rustfmt'
\}
let g:ale_linters = {
\   'go': ['gopls', 'golangci-lint'],
\   'python': ['pyls'],
\   'c': 'all',
\   'cs': 'OmniSharp',
\   'rust': ['rls']
\}
let g:ale_go_golangci_lint_options = '--disable-all -p style -p complexity -p bugs -p format'
let g:ale_go_bingo_options = '--format-style goimports --diagnostics-style none --cache-style=always'

" TODO: Change bingo => gopls when it supports ALEFindReferences
" let g:ale_go_bingo_options = '--diagnostics-style=onsave'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 0

" Emmet
let g:user_emmet_settings={'javascript.jsx': {'extends':'jsx'}, 'javascript': {'extends':'jsx'}, 'typescript.tsx': {'extends':'jsx'}, 'typescript': {'extends':'jsx'}}
let g:jsx_ext_required = 0

" Colors
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:airline_theme='gruvbox'

colorscheme gruvbox

