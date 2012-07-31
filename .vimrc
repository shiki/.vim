" This must be first, because it changes other options as side effect
" http://nvie.com/posts/how-i-boosted-my-vim/
set nocompatible

call pathogen#infect()
syntax on
filetype plugin indent on

:colorscheme molokai
set guifont=DejaVu\ Sans\ Mono:h12.00

set virtualedit=all
set hidden
set nowrap        " don't wrap lines
set tabstop=2     " a tab is 2 spaces
set expandtab
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title

set nobackup
set noswapfile

set cpoptions+=$

" Margin
set colorcolumn=100

" NERD Tree
nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>

" http://stackoverflow.com/a/10417725/246142
silent! map <F3> :NERDTreeFind<CR>

" NERD window size
let NERDTreeWinSize=50

set splitright
"set splitbottom

:command! NT NERDTree

" Hide toolbar in MacVim http://jonatkinson.co.uk/removing-toolbar-macvim/
if has("gui_running")
    set guioptions=egmrt
endif

" https://github.com/kien/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_switch_buffer = 1 " When opening a file, only jump to the buffer if it's opened in the current tab.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_Store  " MacOSX/Linux

" http://stackoverflow.com/a/4800295/246142
set completeopt+=longest

" Auto-hide autocomplete preview window after insert mode
" http://stackoverflow.com/a/3106859/246142
augroup GoAwayPreviewWindow
autocmd! InsertLeave * wincmd z
augroup end

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
    \ if &omnifunc == "" |
    \  setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
endif

" https://github.com/Shougo/neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" ejs support
if has("autocmd")
    au BufRead,BufNewFile *.ejs setfiletype html
endif

" Make + and - add a blank line below or above respectively
nmap + :put =''<CR>
nmap - :put! =''<CR>

" MiniBufExpl
let g:miniBufExplCloseOnSelect = 1
nmap <C-TAB> :MiniBufExplorer<cr>
" Prevent auto-open of MBE unless you tell it to
let g:miniBufExplorerMoreThanOne=999999

" TagBar
nmap <F4> :TagbarOpen fjc<cr>

" CoffeeTags
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif
