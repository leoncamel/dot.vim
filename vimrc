"
" Author       :	Xiaolin Zhang
" Last Modified:	2011-06-01
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"
" Originally from : http://www.vi-improved.org/vimrc.php
"

" Notes {
    " 1. For the first Time, you should create the following two directory
    "   $ mkdir -p ~/.vim/tmp/
    "   $ mkdir -p ~/.vim/backup/
    "   As suggested in IRC channel, you can add the following line: 
    "call mkdir(expand('~/.vim/backup'), 'p', '0755')
    "   But, it seems very ugly.
    " 2.
" }

" Basics {
    " When started as "evim", evim.vim will already have done these
    " settings.
    if v:progname =~? "evim"
        finish
    endif

    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set background=dark " we plan to use a dark background
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             |||||||      between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             ||||||      pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             |||||      buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             |||      when using :@r
    "             |||+-- Searching continues at the end of the match
    "             ||      at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    set cinoptions=s,e0,n0,f0,{0,}0,^0,:0,=s,l0,g0,hs,ps,ts,+s,c3,C0,(2s,us,U0,w0,m0,j0,)20,*30
    syntax on " syntax highlighting on
" }

" General {
    filetype plugin indent on " load filetype plugins/indent settings
    "set autochdir " always switch to the current file directory
    set backspace=indent,eol,start " make backspace a more flexible
    set backup " make backup files
    set backupdir=~/.vim/backup " where to put backup files
    set clipboard+=unnamed " share windows clipboard
    set directory=~/.vim/tmp " directory to place swap files in
    set fileformats=unix,dos,mac " support all three, in this order
    set hidden " you can change buffers without saving
    " (XXX: #VIM/tpope warns the line below could break things)
    set iskeyword+=_,$,@,%,# " none of these are word dividers
    "set mouse=a " use mouse in GUI only
    set noerrorbells " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                    \*.jpg,*.gif,*.png
    "set wildmode=list:longest " turn on wild mode huge list
    set wildmode=longest:list,full
    set history=50          " keep 50 lines of command line history
" }

" Vim UI {
    "set cursorcolumn " highlight the current column
    "set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    "set list " we do what to show tabs, to ensure we get them
              " out of my files
    set listchars=tab:>-,trail:- " show tabs and trailing
    set matchtime=5 " how many tenths of a second to blink
                     " matching brackets for
    "set nohlsearch " do not highlight searched for phrases
    "set showmatch
    set hlsearch    " we DO highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    "set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
    " TODO : Another statusline 
    " Two time fucntion: used in statusline {
    fu! FileTime()
        let ext=tolower(expand("%:e"))
        let fname=tolower(expand('%<'))
        let filename=fname . '.' . ext
        let msg=""
        let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))
        return msg
    endf

    fu! CurTime()
        let ftime=""
        let ftime=ftime." ".strftime("%b,%d %y %H:%M:%S")
        return ftime
    endf
    " }
    set statusline=%<%f%<%{FileTime()}%<%h%m%r%=%-20.(line=%03l,col=%02c%V,totlin=%L%)\%h%m%r%=%-30(,BfNm=%n%Y%)\%P\*%=%{CurTime()}
    set rulerformat=%15(%c%V\ %p%%%)
" }

" Text Formatting/Layout {
    set completeopt=        " don't use a pop up menu for completions
    set expandtab           " no real tabs please!
    set formatoptions=rq    " Automatically insert comment leader on return,
                            " and let gq format comments
    "set ignorecase     " case insensitive by default
    set smartcase
    set infercase       " case inferred by default
    "set nowrap         " do not wrap line
    set wrap
    set shiftround      " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase       " if there are caps, go case-sensitive
    set shiftwidth=4    " auto-indent amount when using cindent,
                        " >>, << and stuff like that
    set softtabstop=4   " when hitting tab or backspace, how many spaces
                        " should a tab be (see expandtab)
    set tabstop=8       " real tabs should be 8, and they will show with
                        " set list on
    set colorcolumn=90
" }

" Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
                        " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still
                      " fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements
                                                      " open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function
                                   " (cleaner than default)
" }

" Plugin Settings {
    let b:match_ignorecase = 1 " case is stupid
    let perl_extended_vars=1 " highlight advanced perl vars
                              " inside strings

    " pathogen {
        call pathogen#infect()
    " }

    " c-support {

    " }

    " Leader Setting {
        " Change <Leader>
        let mapleader = ","
    " }

    " TagList Settings {
        let Tlist_Auto_Open=0 " let the tag list open automagically
        let Tlist_Compact_Format = 1 " show small menu
        let Tlist_Ctags_Cmd = 'ctags' " location of ctags
        let Tlist_Enable_Fold_Column = 0 " do show folding tree
        let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill
                                        " yourself
        let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
        let Tlist_Sort_Type = "name" " order by
        let Tlist_Use_Right_Window = 0 " split to the right side
                                        " of the screen
        let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always)
                                 " read my functions
                                 "
        " Language Specifics {
            " just functions and classes please
            let tlist_aspjscript_settings = 'asp;f:function;c:class' 
            " just functions and subs please
            let tlist_aspvbs_settings = 'asp;f:function;s:sub' 
            " don't show variables in freaking php
            let tlist_php_settings = 'php;c:class;d:constant;f:function' 
            " just functions and classes please
            let tlist_vb_settings = 'asp;f:function;c:class' 
        " }
    " }

    " cscope Settings {
        " cscope add .
        " "cscope add /usr/src/linux-2.6.8.1/ /usr/src/linux-2.6.8.1/
        "
        map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
        nmap <F10> <C-O>
        nmap <F11> <C-I>


        map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
        map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

        nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

        " "nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
        " "nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        " "nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
        "
        " " Hitting CTRL-space *twice* before the search type does a vertical
        " " split instead of a horizontal one
        "
        " "nmap <C-Space><C-Space>s
        " " \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space><C-Space>g
        " " \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space><C-Space>c
        " " \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space><C-Space>t
        " " \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space><C-Space>e
        " " \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
        " "nmap <C-Space><C-Space>i
        " " \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        " "nmap <C-Space><C-Space>d
        " " \:vert scs find d <C-R>=expand("<cword>")<CR><CR>
        "
        "
    " }

    " gtags Settings {
        map <C-n> :cn<CR>
        map <C-p> :cp<CR>
        "map <C-g> :Gozilla<CR>
        map <C-]> :GtagsCursor<CR>
        nmap <C-g> :Gtags <C-R>=expand("<cword>")<CR><CR>
        nmap <C-g><C-r> :Gtags -r <C-R>=expand("<cword>")<CR><CR>
        nmap <C-g><C-s> :Gtags -s <C-R>=expand("<cword>")<CR><CR>
        "nmap <C-g><C-g> :Gtags -g <C-R>=expand("<cword>")<CR><CR>
    " }

    " minibuffexpl Settings {
        " Disable it
        let loaded_minibufexplorer = 1
        " Enable "Ctrl+[hjkl]"
        "let g:miniBufExplMapWindowNavVim = 1
        " Enable "Ctrl+Arrow"
        "let g:miniBufExplMapWindowNavArrows = 1
        " Enable Ctrl+Tab and Ctrl+Shift+Tab
        "let g:miniBufExplMapCTabSwitchBufs = 1
        "let g:miniBufExplMapCTabSwitchWindows = 1
        " Use single click instead of double click on tabs
        "let g:miniBufExplUseSingleClick = 1
    " }

    " Haskell-Mode Settings {
        """"""""""""""""""""""""haskell mode"""""""""""""""""""""""""""""""""""""
        " use ghc functionality for haskell files
        "au Bufenter *.hs compiler ghc
        "set expandtab

        " ===== Haskell mode ==================================================
        "autocmd! BufReadPre,FileReadPre      *.hs   so ~/.vim/haskell.vim
        "autocmd! BufReadPre,FileReadPre      *.lhs  so ~/.vim/haskell.vim
        "autocmd! BufReadPre,FileReadPre      *.erl  so ~/.vim/haskell.vim
        autocmd! BufReadPre,FileReadPre      *.hs   set expandtab
        autocmd! BufReadPre,FileReadPre      *.hsc  set expandtab
        autocmd! BufReadPre,FileReadPre      *.lhs  set expandtab

        " configure browser for haskell_doc.vim
        "let g:haddock_browser = "insert path to your web browser"
        let g:haddock_browser = "/usr/bin/firefox"
        "let g:haddock_browser = "C:/Program Files/Opera/Opera.exe"
        "let g:haddock_browser = "C:/Program Files/Mozilla Firefox/firefox.exe"
        "let g:haddock_browser = "C:/Program Files/Internet Explorer/IEXPLORE.exe"
    " }

    " vimwiki Settings {
        """"""""""""""""vimwiki""""""""""""""""""
        " change "d:/vimwiki/" to whatever you prefer - "~/my wiki/" for example.
        " set your wiki files homedir
        "let g:vimwiki_home = "~/public_html/vimwiki/"
        let g:vimwiki_list = [{'path': '~/MyWiki/',
                             \ 'path_html': '~/public_html/'}]
    " }

    " Viki Settings {
        " Viki
        let g:vikiNameSuffix=".viki"
        autocmd! BufRead,BufNewFile $HOME/MyWiki/* set filetype=viki
        let g:vikiHomePage = $HOME . "/MyWiki/index"
    " }

    " Latex/Context Settings {
        let g:tex_flavor = "context"
    " }

    " Python Settings {
        set tags+=$HOME/.vim/tags/python.ctags
        autocmd FileType python set omnifunc=pythoncomplete#Complete

        autocmd FileType python setl autoindent
        autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
        autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
    " }

    " Asymptote Settings {
        augroup filetypedetect
            au BufNewFile,BufRead *.asy     setf asy
        augroup END
        filetype plugin on
    " }

    " Pandoc Settings {
        au! Bufread,BufNewFile *.pdc set filetype=pdc
        au! Bufread,BufNewFile *.md set filetype=pdc
        au! Bufread,BufNewFile *.markdown set filetype=pdc
    " }

    " Thrift Settings {
        au BufRead,BufNewFile *.thrift set filetype=thrift
        au! Syntax thrift source ~/.vim/syntax/thrift.vim
    " }

    " snipMate Settings {
         let g:snips_author = 'Leon Zhang'
    " }

    " pysmell Settings {
    "    python import pysmell
    "    autocmd FileType python setlocal omnifunc=pysmell#Complete
    " }

    " screen Settings {
    "    let g:ScreenImpl = 'Tmux'
    " }

    " Ack Settings {
        let g:ackprg="ack-grep -H --nocolor --nogroup --column"
        vmap ,mc !boxes -d c-cmt<CR>
        nmap ,mc !!boxes -d c-cmt<CR>
        vmap ,xc !boxes -d c-cmt -r<CR>
        nmap ,xc !!boxes -d c-cmt -r<CR>
    " }
" }

" Mappings {
    " ROT13 - fun
    map <F12> ggVGg?

    " space / shift-space scroll in normal mode
    noremap <S-space> <C-b>
    noremap <space> <C-f>

    " Make Arrow Keys Useful Again {
        "map <left> <ESC>:NERDTreeToggle<RETURN>
        "map <right> <ESC>:Tlist<RETURN>
        map <down> <ESC>:bn<RETURN>
        map <left> gT
        map <right> gt
        map <up> <ESC>:bp<RETURN>
    " }
    " My Own Map {
        nmap j gj
        nmap k gk

        " Switching tabs
        noremap <A-h> gT
        noremap <A-l> gt

        nmap <F9> :Tlist<CR>

        nnoremap  <leader>sf :vimgrep <C-R><C-W> %<CR> :cw<CR>
    " }
" }

" Autocommands {
    " Auto Restore old position {
        if has("autocmd")
            " Put these in an autocmd group, so that we can delete
            " them easily.
            augroup vimrcEx
            au!

            " For all text files set 'textwidth' to 78 characters.
            autocmd FileType text setlocal textwidth=78

            " When editing a file, always jump to the last known cursor
            " position. Don't do it when the position is invalid or when
            " inside an event handler (happens when dropping a file on gvim).
            " Also don't do it when the mark is in the first line, that is
            " the default position when opening a file.
            autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

            augroup END
        endif

    " }
    " Ruby {
        " ruby standard 2 spaces, always
        au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 
        au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 
    " }
    " Notes {
        " I consider .notes files special, and handle them differently, I
        " should probably put this in another file
        au BufRead,BufNewFile *.notes set foldlevel=2
        au BufRead,BufNewFile *.notes set foldmethod=indent
        au BufRead,BufNewFile *.notes set foldtext=foldtext()
        au BufRead,BufNewFile *.notes set listchars=tab:\ \
        au BufRead,BufNewFile *.notes set noexpandtab
        au BufRead,BufNewFile *.notes set shiftwidth=8
        au BufRead,BufNewFile *.notes set softtabstop=8
        au BufRead,BufNewFile *.notes set tabstop=8
        au BufRead,BufNewFile *.notes set syntax=notes
        au BufRead,BufNewFile *.notes set nocursorcolumn
        au BufRead,BufNewFile *.notes set nocursorline
        au BufRead,BufNewFile *.notes set guifont=Consolas:h12
        au BufRead,BufNewFile *.notes set spell
    " }
    au BufNewFile,BufRead *.ahk setf ahk 
" }

" GUI Settings {
if has("gui_running")
    " Basics {
        "colorscheme desert   " my color scheme (only works in GUI)
        " colorscheme pablo
        " colorscheme darkblue
        " colorscheme inkpot
        " colorscheme midnight2
        " colorscheme wombat256
        colorscheme desert

        set columns=95 " perfect size for me
        "set guifont=Consolas:h10 " My favorite font
        "set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
        set guifont=DejaVu\ Sans\ Mono\ 14
        "set guifont=Monaco:h14
        set guioptions=ce 
        "              ||
        "              |+-- use simple dialogs rather than pop-ups
        "              +  use GUI tabs, not console style tabs
        "set guioptions-=T
        "set guioptions-=m

        set lines=55 " perfect size for me
        set mousehide " hide the mouse cursor when typing
        set mouse=a   " use mouse in GUI only
    " }

    " Font Switching Binds {
        map <F8> <ESC>:set guifont=Consolas:h8<CR>
        map <F9> <ESC>:set guifont=Consolas:h10<CR>
        map <F10> <ESC>:set guifont=Consolas:h12<CR>
        map <F11> <ESC>:set guifont=Consolas:h16<CR>
        map <F12> <ESC>:set guifont=Consolas:h20<CR>
    " }

    " MacVim {
        "set fuopt=maxvert,maxhorz " for macvim fullscreen
    " }
endif
" }

" Misc Settings {
    " Removes trailing spaces {
        function TrimWhiteSpace()
        : %s/\s*$//
        : ''
        :endfunction

        "set list listchars=trail:.,extends:>
        "autocmd FileWritePre   * :call TrimWhiteSpace()
        "autocmd FileAppendPre  * :call TrimWhiteSpace()
        "autocmd FilterWritePre * :call TrimWhiteSpace()
        "autocmd BufWritePre    * :call TrimWhiteSpace()
        map <F2>   :call TrimWhiteSpace()<CR>
        map! <F2>  :call TrimWhiteSpace()<CR>
    " }

    " Highlight Redundent spaces {
        " from : http://lkml.org/lkml/2007/6/29/124
        highlight RedundantSpaces ctermbg=red guibg=red
        match RedundantSpaces /\s\+$\| \+\ze\t/
    " }

    " Tips about vim7 Settings {
        " copy from http://www.cs.swarthmore.edu/help/vim/vim7.html
        if has("spell")
        " turn spelling on by default
        set spell

        " toggle spelling with F4 key
        map <F4> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

        " they were using white on white
        highlight PmenuSel ctermfg=black ctermbg=lightgray

        " limit it to just the top 10 items
        set sps=best,10

        set spell!
        endif
    " }
    " Consider *.cmd as scheme (for Synopsys ) Settings {
        :let do_synopsys_filetypes=1
        if exists("do_synopsys_filetypes")
            "au BufRead,BufNewFile *.cmd             setfiletype scheme
            au BufEnter *.cmd             setfiletype scheme
        endif
    " }

    " Swap Two Char/Words/Line {
        """"""""""""""""""""""""" swap character/word """""""""""""""""""""""""
        " To use gc to swap the current character with the next
        nnoremap <silent> gc xph

        " To use gw to swap the current word with the next
        nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
        " This version will work across newlines:
        nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

        " To use gl to swap the current word with the previous
        nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
        " To use gr to swap the current word with the next
        nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>
        " To use g{ to swap the current paragraph with the next:
        nnoremap g{ {dap}p{
    " }

    " Insert 'Last Modified" {

        " If buffer modified, update any 'Last modified: ' in the first 20 lines.
        " 'Last modified: ' can have up to 10 characters before (they are retained).
        " Restores position using s mark.
        "   function! LastModified()
        "     if &modified
        "       normal ms
        "       let n = min([20, line("$")])
        "       exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
        "             \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
        "       normal `s
        "     endif
        "   endfun
        "   autocmd BufWritePre * call LastModified()

        " autodate
        "-----------------------------------------------------------
        let g:autodate_format = '%Y-%m-%d'
        let g:autodate_keyword_pre = 'Last Modified:'
        let g:autodate_keyword_post = '$'

    " }

    " Finally "No Noisy" Beep {
        " set silient(no beep)
        set vb t_vb=".
    " }
" }


" vim: set foldmarker={,} foldlevel=0 spell:
