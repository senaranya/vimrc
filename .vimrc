" ------------------------ Tips ----------------------------
" To open a file in a new tab: :tabedit <file>. To go to next one: :gt, close it, :bd
" To see recent files: ctrl+e
" To open file explorer pane: ctrl+b
" To clear search results: :H
" Bring the line you're on to the middle of the screen: zz
" Search from within vim: :Ag
"
" Manage TBDs:
"   
"
" Bookmarking tips: 
"   Use capital letters to set bookmarks that work _across_ files.
"   Use backtick (`) instead of single quote to return to exact cursor position
"   Use :marks to list current bookmarks
"   Vim automatically bookmarks last known positions from 0-9. So, to go to last edited file, hit `0
"
" Macro tips:
"   q<char> to start recording. q to stop. @<char> to play it back.
"   :reg to list current macros
"   To save a macro for later use: 
"       "<char>p to print recorded macro. 
"       save it in .vimrc as: let @<char>="<text>"
"       To use, hit @<char>
" 
" Surroundings (i.e., quote, paranthesis, braces, xml tags etc.):
"     To yank/delete/change/select everything inside a surrounding use <d/c/v>i<quote/paran/brace...>
"       e.g., 
"       Delete inside paranthesis: di(
"       Delete inside quotes: di"
"       Change inside quotes: ci"
"       Select inside braces: vi{
"     To do above _including_ the surroundings, replace 'i' with 'a'. e.g. da', va{ etc. 
"     To change surroundings: cs<source><dest>. e.g.,
"       cs'": Change single quotes to double quotes
"       cs'<div>: Place a <div></div> around a single-quoted string
"       dst: Delete surrounding tag (e.g., above <div> tag)
"       ds": Remove double quotes
"       (For more, see https://github.com/tpope/vim-surround)
"
" To use ctag: 
"   ctag -R to generate tags
"   To go to a method definition:
"       Bring the cursor on the method, and hit ctrl+]
"       Type ,f (or :tag) <method name> to go to the method
"   :tn to go to next occurance
"   :tp to go to previous occurance
"   :ts to select from all tags available
"
" TBD : 
"   Shortcut to beautify current file
"   Paste with correct indentation
"   List TBDs from project / current file / directory 
"   macro ideas: when a parameter is added inside a method, playing a macro should add $this->param; and protected $param; and possibly a docblock.
"   shortcut to untabify a file (convert from tabs to spaces)
" Laravel specific:
"   ,lr : Open routes file
"   TBD : Write other shortcuts
" To sort a set of lines according to length (e.g., use it on use/require statements): select lines, hit: ,su
"
" Autocompletions:
"   ctrl+n:
"   tab: Comes from plugin 'Supertab'
"
" PHP specific:
"   ,pf : Format PHP file according to PSR2
"
" Vim configurations
"   ,ev : Edit ~.vimrc file
"   ,es : Edit a snippet file
"   TBD : shortcut for Plugins file

"-----------------------------------------------------------

" -------------- Global Init --------------
    set nocompatible                " We want the latest vim settings/options
    source ~/.vim/plugins.vim       " Init Vundle configuration containing plugins. To install new plugins, issue :PluginInstall
    
    "execute pathogen#infect()      " Remove this Pathogen configuration after May 2016 if no issues with 
    "filetype plugin indent on      " Vundle for me
    
    set wildmenu
    set ruler
    set completeopt-=preview        " disable the sucking pydoc preview window for the omni completion
    set gcr=a:blinkon0              " Highlight current line and disable the blinking cursor
    
    " When line numbers are on, select only the text and not line numbers when dragging with mouse
    " This has a side-effect -- You can't copy a text to clipboard! 
    " Either hold down shift while copying and right clicking, or do a set mouse=v to temporarily turn on copy-to-clipboard
    set mouse=a

    set timeout timeoutlen=1000 ttimeoutlen=100 " timeout between key-combinations
    
    " Set a map leader (with a map leader it is possible to extra key combinations. e.g., <leader>w saves the current file)
    let mapleader = ","
    let g:mapleader = ","
    
" -------------- Search -------------------
    set ignorecase                  " Ignore case when searching
    set smartcase                   " Ignore case if search pattern is all lowercase
    command! H let @/=""            " Remove Search results by typing :H
    set hlsearch
    set incsearch

" -------------- Indentation -------------------
    set tabstop=4
    set softtabstop=4	            " When hitting <BS>, pretend like a tab is removed, even if spaces
    set expandtab		            " Expand tabs by default, (overridable per file type later)
    set shiftwidth=4	            " number of spaces to use for autoindenting
    set shiftround                  " Use multiple of shiftwidth when indenting with '<' or '>'
    set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
    set smarttab
    set autoindent
    set copyindent                  " Copy the previous indentation on autoindenting

    " Command to untabify
    " Examples:
    "    Convert all leading spaces to tabs (default range is whole file):  :Space2Tab
    "    Convert lines 11 to 15 only (inclusive): :11,15Space2Tab
    "    Convert last visually-selected lines: :'<,'>Space2Tab
    "    Same, converting leading tabs to spaces: :'<,'>Tab2Space
    :command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

" -------------- Visuals -------------------
    if has("gui_running")
      set guifont=Fira\ Code:h9
      colorscheme materialbox
    else
      colorscheme spacegray
    endif

    set t_Co=256                    " Use 256 colors
    syntax on
    set nonumber                      " Always show line numbers
    set nowrap                      " Do not wrap lines
    set textwidth=140               " After 140 characters, break into next line
    set guioptions-=T               " (GUI only) Disable toolbar
    set linespace=7                 " (GUI only) Spacing between lines
    set noerrorbells visualbell t_vb=  " Don't beep!
    
    " My PC is fast enough, do syntax highlight syncing from start
    autocmd BufEnter * :syntax sync fromstart
    
    set cmdheight=2                 " Make the command line two lines high

    " set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w  " Not required with Airline enabled
    
    " Airline Status Bar 
    " (For more cool customizations: https://github.com/vim-airline/vim-airline)
    set laststatus=2
    let g:airline#extensions#tabline#enabled = 1 " Smarter tab line (Automatically displays all buffers when there's only one tab open)
    let g:airline_powerline_fonts = 1

    " The line number bar and split bars bg and fg colors (set it after Airline)
    highlight LineNr ctermbg=None ctermfg=166
    highlight VertSplit ctermbg=None ctermfg=172

" -------------- Split Management -------------------
    set splitbelow  " A new horizontal split opens it to the left
    set splitright  " A new vertical split opens it to the right
    
    " Move around split screens easily (press ctrl+h/j/k/l to switch to left/down/up/right window)
    nmap <C-h> <C-w>h
    nmap <C-j> <C-w>j
    nmap <C-k> <C-w>k
    nmap <C-l> <C-w>l

" -------------- File Explorer and management ---------
    " Toggle file explorer pane
    nmap <C-b> :NERDTreeToggle<cr>
    
    " Ensure NerdTree doesn't hijack Vinegar's controls
    let NERDTreeHijackNetrw = 0
    
    " ----- ctrlP plugin -----
    set runtimepath^=~/.vim/bundle/ctrlp.vim
    let g:ctrlp_custom_ignore = 'node_modules\|git'
    let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
    
    " Access recently used files
    nmap <C-e> :CtrlPMRUFiles<cr>
    
    " Ignore folders 
    set wildignore+=*/vendor/**
    set wildignore+=*/.git/**
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    
    " hide some files and remove stupid help
    let g:explHideFiles='^\.,.*\.sw[po]$,.*\.pyc$'
    let g:explDetailedHelp=0


" ------------------ Misc ---------------------
    " Down is really the next line
    nnoremap j gj
    nnoremap k gk

    " Faster saves
    nmap <leader>w :w!<cr>

    " Minibuffer
    " ----------
    "  one click is enough and fix some funny bugs
    let g:miniBufExplUseSingleClick = 1
    let g:miniBufExplMapCTabSwitchBufs = 1
    
    " BufClose
    " --------
    "  map :BufClose to :bq and ^B and configure it to open a file browser on close
    let g:BufClose_AltBuffer = '.'
    cnoreabbr <expr> bq 'BufClose' 
    " map  :BufClose<CR>
    "

    " Automatically save the file when switching buffer (i.e., to other file)
    set autowriteall

" ------------------ Language Supports ------------------
    "  ctag
    " ,f types :tag 
    nmap <Leader>f :tag<space>

    " Sort 'use'/'require' statements from shortest to longest
    vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

    set complete=.,w,b,u            " Set desired autocompletions
    
    " php support
    " Add missing 'use' statements (test if it works. Else remove it)
    function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
    endfunction
    autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR> 

    " Complete fully qualified path for the given class
    function! IPhpExpandClass()
        call PhpExpandClass()
        call feedkeys('a', 'n')
    endfunction
    autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
    autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

    " Format PHP file according to PSR2
    let g:php_cs_fixer_level = "psr2"
    nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

    " Emmet configurations
    let g:user_emmet_settings = {
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'c',
      \  },
      \  'xml' : {
      \    'extends' : 'html',
      \  },
      \  'haml' : {
      \    'extends' : 'html',
      \  },
      \}

"------------------ Laravel Specific ---------------------
    " ,lr : Open routes.php file
    nmap <Leader>lr :e app/Http/routes.php<cr>  
    
    " ,lm : Command: php artisan make:
    nmap <Leader>lm :!php artisan make:
    
    " ,c / ,m / ,v : Go to controllers, models or views directories respectively
    nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
    nmap <Leader><Leader>m :e app/<cr>
    nmap <Leader><Leader>v :e resources/views/<cr>
    
    " ,ll : Open laravel.log file in a new tab
    nmap <Leader>ll :tabedit storage/logs/laravel.log<cr>

    " Vim Commentary - add comment type for blade files
    autocmd FileType blade setlocal commentstring={{--%s--}}

"------------------ Vim Configurations ----------------
    nmap <Leader>ev :tabedit $MYVIMRC<cr>
    nmap <Leader>es :e ~/.vim/snippets/

"------------------ Auto Commands ---------------------
    " Automatically source vimrc when saved
    augroup autosourcing
        autocmd!
        autocmd BufWritePost .vimrc source %
    augroup END

