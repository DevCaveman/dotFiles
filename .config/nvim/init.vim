" ============================================================================
" Vim-plug initialization
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.local/share/nvim/site/autoload
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the init.vim as you wish :)

" ============================================================================

" Active Plugins
call plug#begin('~/.config/nvim/plugged')

" ALE linter
Plug 'w0rp/ale'

" Autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" JavaScript Stuff(flow-bin, ESlint and Prettier needed)
Plug 'pangloss/vim-javascript'

" Vertical indent lines
Plug 'Yggdroot/indentLine'

" Show folders
Plug 'scrooloose/nerdtree'

" commenter toll
Plug 'scrooloose/nerdcommenter'

" Show all tags in the code(need ctags)
Plug 'majutsushi/tagbar'

" Better status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" change surroundings - 'Olá' -> cs'@ -> @Olá@
Plug 'tpope/vim-surround'

" Paython stuff
"Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

" syntax highlight
Plug 'scrooloose/syntastic'

" emmet
Plug 'mattn/emmet-vim'

" auto colse ¨ ' () {} [] etc.. 
Plug 'jiangmiao/auto-pairs'

" git plugin
Plug 'tpope/vim-fugitive' 

" better way to change splits
Plug 't9md/vim-choosewin'

" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
"Plug 'honza/vim-snippets'
"Plug 'garbas/vim-snipmate'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Show colors of #rrggbb or #rgb
Plug 'lilydjwg/colorizer'

" Select by indentation in visual mode -> ii/ai/iI/aI
Plug 'michaeljsmith/vim-indent-object'

" foldind code by indentation - press spacebar
Plug 'tmhedberg/SimpylFold'

" show match numbers - Match #N of M - g/ or \\ or \/
Plug 'vim-scripts/IndexedSearch'

" Extended % matching fot HTML, LaTeX and etc.
Plug 'vim-scripts/matchit.zip'

" Maintains a history of previous yanks, changes and deletes.
Plug 'vim-scripts/YankRing.vim'

" themes
Plug 'crusoexia/vim-monokai'
Plug 'reewr/vim-monokai-phoenix'
Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Install plugins the first time vim runs
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================

" Cursor highlight \z toggle
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>z :set cursorline! cursorcolumn!<CR>

" Enable cursor highlight on (n)Vim initialization
"set cursorline
"set cursorcolumn

" always show status bar
set ls=2

" syntax highlight on
:syntax on

" show line numbers and relative numbers
set nu
set rnu

" COPIAR, COLAR e RECORTAR (clip board)
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p

" Toggle mouse \m 
set mouse=a
nnoremap <Leader>m :set mouse=a<CR>


" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType zsh setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType json setlocal shiftwidth=4 tabstop=4 softtabstop=4

" incremental search
set incsearch

" highlighted search results
nnoremap <Leader>f :set hlsearch!<CR>
set hlsearch

" set spell
nnoremap <Leader>s :setlocal spell spelllang=pt_br<CR>

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map tc :tabclose 
map ts :tab split<CR>

" navigate windows with meta+arrows
"map <C-L> <c-w>l
"map <C-H> <c-w>h
"map <C-K> <c-w>k
"map <C-J> <c-w>j
"imap <C-L> <ESC><c-w>l
"imap <C-H> <ESC><c-w>h
"imap <C-K> <ESC><c-w>k
"imap <C-J> <ESC><c-w>j

" completion?
"set completeopt-=preview
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 10 lines away from screen border
set scrolloff=10

" better backup, swap and undos storage
set directory=~/.config/nvim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.config/nvim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.config/nvim/dirs/undos
set viminfo+=n~/.config/nvim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.config/nvim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" No arrow keys for you!
noremap <Up> :echo "SEM SETAS! HAHAHA... use  w  animal!"<CR>
noremap <Down> :echo "SEM SETAS! HAHAHA... use  j  animal!"<CR>
noremap <Left> :echo "SEM SETAS! HAHAHA... use  h  animal!"<CR>
noremap <Right> :echo "SEM SETAS! HAHAHA... use  l  animal!"<CR>

vnoremap <Up> :<C-u>echo "SEM SETAS! HAHAHA... use  l  animal!"<CR>
vnoremap <Down> :<C-u>echo "SEM SETAS! HAHAHA... use  j  animal!"<CR>
vnoremap <Left> :<C-u>echo "SEM SETAS! HAHAHA... use  h  animal!"<CR>
vnoremap <Right> :<C-u>echo "SEM SETAS! HAHAHA... use  l  animal!"<CR>

inoremap <Up> <C-o>:echo "SEM SETAS! HAHAHA... use  l  animal!"<CR>
inoremap <Down> <C-o>:echo "SEM SETAS! HAHAHA... use  j  animal!"<CR>
inoremap <Left> <C-o>:echo "SEM SETAS! HAHAHA... use  h  animal!"<CR>
inoremap <Right> <C-o>:echo "SEM SETAS! HAHAHA... use  l  animal!"<CR>

" leader + r to run files
autocmd FileType javascript noremap <Leader>r :execute "!node " . expand('%')<CR>
autocmd FileType python noremap <Leader>r :execute "!python " . expand('%')<CR>

" Enable show commands in status line
set showcmd
set showmode!

" Not wait to redraw the screen
set nolazyredraw

" Show matching symbols
set showmatch

" not case sensitive searchs
set ignorecase

" Enable auto indentation of new lines
set smartindent

" Enable long offscreen lines
"set nowrap

" Set colors
colorscheme wal


"------------------------------------------------------------------------------ 
"                                                                             -
"            -----------------  PLUGINS CONFS  -----------------              -
"                                                                             -
"------------------------------------------------------------------------------

" Simple foldind (press spacebar) ---------------------------------------------
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" Indexedsearch ---------------------------------------------------------------
let g:indexed_search_colors=0

"-------------------------------- JavaScript ----------------------------------
" Prettier
"autocmd FileType javascript set formatprg=prettier\ --stdin
"autocmd BufWritePre *.js :normal gggqG

" ALE
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

" select linters
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Set this in your vimrc file to disabling highlighting
"let g:ale_set_highlights = 0

" ALE indicators
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''


" pangloss (syntax highlight)
"let g:javascript_plugin_jsdoc = 1
"let g:javascript_plugin_ngdoc = 1
"let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END


"------------------------------------------------------------------------------ 

" Emmet (Ctrl+e+,) ------------------------------------------------------------
let g:user_emmet_leader_key='<C-e>'

" Indentation line ------------------------------------------------------------
let g:indentLine_enabled=1
let g:indentLine_char='¦'
map <Leader>l :IndentLinesToggle<CR>

" Tagbar ----------------------------------------------------------------------
" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus=1

" NERDTree --------------------------------------------------------------------
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <F2> :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore=['\.pyc$', '\.pyo$']

" Syntastic ------------------------------------------------------------------
" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open=1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs=1
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
let g:syntastic_error_symbol=''
let g:syntastic_warning_symbol=''
let g:syntastic_style_error_symbol=''
let g:syntastic_style_warning_symbol=''

" Jedi ------------------------------------------------------------------------
" All these mappings work only for python code:
" Go to definition
autocmd FileType python let g:jedi#goto_command=',D'
" Find ocurrences
autocmd FileType python let g:jedi#usages_command=',o'
" Find assignments
autocmd FileType python let g:jedi#goto_assignments_command=',a'
" Go to definition in new tab
autocmd FileType python nmap ,d :tab split<CR>:call jedi#goto()<CR>

" Deoplete --------------------------------------------------------------------
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" deoplete + neosnippet + autopairs changes 
let g:AutoPairsMapCR=0 
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1 
let g:deoplete#enable_smart_case = 1 
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_optional_arguments = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""Keys
imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>") 
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
"imap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


"" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
"let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'

" NerdCommenter ---------------------------------------------------------------
let g:NERDCompactSexyComs=1

" Signify ---------------------------------------------------------------------
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list=[ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Window Chooser --------------------------------------------------------------
" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable=1

" Airline ---------------------------------------------------------------------
let g:airline_powerline_fonts=1
let g:airline_symbolraven=1
let g:airline_theme='serene'
let g:airline_detect_modified=1
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1

" Extensions
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#hunks#enabled=1 
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#syntastic#enabled=1

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols={}
endif

" unicode symbols
"let g:airline_left_sep='»'
"let g:airline_left_sep='▶'
"let g:airline_right_sep='«'
"let g:airline_right_sep='◀'
let g:airline_symbols.crypt=''
"let g:airline_symbols.linenr='␊'
let g:airline_symbols.linenr='␤'
"let g:airline_symbols.linenr='¶'
"let g:airline_symbols.linenr='¥'
"let g:airline_symbols.maxlinenr='㏑'
"let g:airline_symbols.paste='ρ'
let g:airline_symbols.paste='Þ'
let g:airline_symbols.spell=''
let g:airline_symbols.notexists='∄'
let g:airline_symbols.whitespace='Ξ'

" powerline symbols
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.maxlinenr=''

"------------------------------------------------------------------------------ 

