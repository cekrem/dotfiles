" Plugins
call plug#begin()
" Autocomplete
Plug 'mattn/emmet-vim'

" Environment handling
Plug 'tpope/vim-dotenv'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Golang (done via ALE)
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
" Plug 'govim/govim'
"autocmd! User govim call govim#config#Set("QuickfixAutoDiagnostics", 0)
"autocmd! User govim call govim#config#Set("QuickfixSigns", 0)
"autocmd! User govim call govim#config#Set("Staticcheck", 0)
"autocmd! User govim call govim#config#Set("HighlightDiagnostics", 0)

" C#
"Plug 'OmniSharp/omnisharp-vim', { 'do': ':OmniSharpInstall', 'for': 'cs' }
"Plug 'tpope/vim-dispatch'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Lisp
Plug 'kovisoft/slimv'

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
Plug 'lifepillar/vim-solarized8'

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

" Elm
Plug 'elmcast/elm-vim'

" Kotlin
Plug 'udalov/kotlin-vim'

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" YAML formatting (faster)
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }

" HTTP requests
Plug 'nicwest/vim-http'

" SQL
Plug 'tpope/vim-dadbod'

" Org mode (testing!)
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'

" tmux integration/navigation
Plug 'christoomey/vim-tmux-navigator'

" StackOverflow
"Plug 'mickaobrien/vim-stackoverflow'

" Super important stuff
Plug 'mattn/vim-starwars'

call plug#end()

" General settings (not plugin related)
source ~/.vimrc.basics

" Fix å! 
imap å å

" Spellcheck markdown
au FileType markdown setlocal spell

" Intellisense & linting shortcuts
noremap <C-]> :ALEGoToDefinition<CR>
nnoremap <leader>fr :ALEFindReferences<CR> 
nnoremap <leader>p :ALEFix<CR>
nnoremap <leader>v :ALEHover<CR>
nnoremap <leader>d :ALEDetail<CR>
nnoremap <silent> ]w :ALENext<cr>
nnoremap <silent> [w :ALEPrevious<cr>
nnoremap <silent> <leader>w :lopen<cr>
nnoremap <leader>s :setlocal spell<cr>j

" Search
nnoremap <leader>a :Rg<CR>
"nnoremap <leader>s :ALESymbolSearch<Space>
nnoremap <leader>fd :syn clear Repeat \| g/^\(.*\)\n\ze\%(.*\n\)*\1$/exe 'syn match Repeat "^' . escape(getline('.'), '".\^$*[]') . '$"' \| nohlsearch<CR>

" DB shortcuts
au FileType sql nnoremap <leader>dbu :%DB $UAT_DB<CR>
au FileType sql nnoremap <leader>dbm :%DB $MT_DB<CR>
au FileType sql nnoremap <leader>dbp :%DB $PROD_DB<CR>
au FileType sql nnoremap <leader>dbd :%DB $DEV_DB<CR>

" Golang shortcuts
"au FileType go nnoremap <buffer> <leader>r <Plug>(go-run)
"au filetype go nnoremap <buffer> <leader>i <plug>(go-imports);
"au filetype go nnoremap <buffer> <leader>h :govimhighlightreferences<cr>
"au FileType go nnoremap <buffer> <leader>fr :GOVIMReferences<CR>
"au FileType go nnoremap <buffer> <leader>v :<C-u>call GOVIMHover()<CR>
"au FileType go nnoremap <buffer> <leader>gr :GOVIMRename<CR>

" Lisp
au FileType lisp set lisp
au FileType lisp nnoremap <buffer> <leader>p gg=G``
au filetype lisp setlocal equalprg=scmindent

let g:lisp_rainbow=1
let g:slimv_baloon=1
let g:slimv_ctags="/usr/local/bin/ctags"
let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sbcl'

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

" Kotlin tweaks
let g:ale_kotlin_kotlinc_executable = '/usr/local/bin/kotlinc'
let g:ale_kotlin_ktlint_executable = '/usr/local/bin/ktlint'
let g:ale_kotlin_ktlint_executable = '/usr/local/bin/ktlint'
let g:ale_kotlin_languageserver_executable = '/Users/cekrem/code/kotlin-language-server/server/build/install/server/bin/kotlin-language-server'
let g:ale_kotlin_ktlint_options = '--experimental'

" Statusline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:lightline = {}
let g:lightline.colorscheme = 'solarized'
"let g:lightline.active = 'left': { [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ] }
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" Autocomplete
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
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
\   'elm': ['elm-format'],
\   'scss': ['prettier'],
\   'python': ['yapf'],
\   'sql': ['pgformatter'],
\   'json': ['prettier'],
\   'html': ['prettier'],
\   'xml': ['xmllint'],
\   'css': ['prettier'],
\   'go': ['goimports'],
\   'markdown': ['prettier'],
\   'c': ['clang-format'],
\   'cs': ['uncrustify'],
\   'rust': 'rustfmt'
\}
let g:ale_linters = {
\   'go': ['gopls', 'golangci-lint'],
\   'markdown': ['prettier'],
\   'elm': ['elm_ls'],
\   'python': ['pyls'],
\   'c': 'all',
\   'cs': 'OmniSharp',
\   'kotlin': 'languageserver',
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
set background=light
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let g:airline_theme='solarized'

" Org mode
nnoremap <leader>.t :e ~/Dropbox/org/main.org<CR> 
let g:org_agenda_files = ['~/code/*.org']
let g:org_todo_keywords=['TODO', 'IN-PROGRESS', 'IN-REVIEW',  'BLOCKED', 'LATER',  '|', 'DONE', 'DELEGATED']

colorscheme solarized8

