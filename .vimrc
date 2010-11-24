"============ system configuration ============
" vi compatible mode
    set nocompatible
" WinVIM-like behavior
    "source $VIMRUNTIME/vimrc_example.vim
    if has("gui_running")
        source $VIMRUNTIME/mswin.vim
        behave mswin
    endif
" setting current directory to working directory
    "set bsdir=buffer
    "set autochdir
" temperary backup files
    set nobackup
    set directory=$HOME/.vimswp
" share the clipboard with Windows
    set clipboard+=unnamed
"============ system configuration ============


"============ search setting ============
" searching result highlighting
    set hlsearch
" searching ignoring capitalization
    set ignorecase
" incremental search
    set incsearch
"============ search setting ============


"============ <tab> setting ============
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
" show tabs as ">---"
    set listchars=tab:>-
    set list
"============ <tab> setting ============


"============ visual settings ============
" window width
    "set columns=100
" line number
    set number
    set ruler
" color support
    if has("gui_running")
        " full color
    else
        set t_Co=256
    endif
" color theme
    if has("gui_running")
        "colorscheme native
        "colorscheme ir_black
        colorscheme wombat
    else
        "colorscheme xterm16
        "colorscheme native
        "colorscheme ir_black
        colorscheme wombat256
    endif
" highlight current line & column
    "if has("gui_running")
        set cursorline
        set cursorcolumn
    "endif
" key word background
    "set background=dark
" color syntax
    syntax on
" font
    set gfn=Monospace\ 9
    set gfw=
" comment color
    "highlight Comment ctermfg=darkcyan
" search color
    "highlight Search term=reverse ctermbg=4 ctermfg=7
    "highlight Normal ctermbg=black ctermfg=white
" txt width alarm
    autocmd BufRead,BufNewFile *.txt syntax match Search /\%<82v.\%>81v/
    "autocmd BufRead,BufNewFile *.txt syntax match ErrorMsg /\%>80v.\+/
"============ visual settings ============


"============ file type detect ============
" loading the plugin files for specific file types
    filetype plugin on
" loading the indent file for specific file types 
    filetype indent on
"============ file type detect ============


"============ smart match ============
"briefly jump to the matching one
    set showmatch
"search the match of if/else/end...etc
"this plugin is embedded in VIM 7.x, but not loaded defaultly
    source $VIMRUNTIME/macros/matchit.vim
"============ smart match ============


"============ indent ============
" auto indent
    set autoindent!
    set smartindent
    set cindent
"ai: auto indent.
"et: replace tabs to spaces.
"sw: set width (for indent).
"ts: tabstop, the width of tab.
"sts: soft tab stop, the width of tab. this set is related to how
"     the <BS> works on space-replaced tabs.
    autocmd BufRead *.rb   set ai sw=2 ts=2 sts=2 fdm=indent et 
    autocmd BufRead *.py   set ai sw=2 ts=2 sts=2 fdm=indent et 
    autocmd BufRead *.c    set ai sw=4 ts=4 sts=4 fdm=indent et 
    autocmd BufRead *.cpp  set ai sw=4 ts=4 sts=4 fdm=indent et 
    autocmd BufRead *.go   set ai sw=4 ts=4 sts=4 fdm=indent
    autocmd BufRead *.java set ai sw=4 ts=4 sts=4 fdm=indent et 
    autocmd BufRead *.mk   set ai sw=4 ts=4 sts=4
    autocmd BufRead *.vala set ai sw=4 ts=4 sts=4 fdm=indent et 
    autocmd BufRead *.vapi set ai sw=4 ts=4 sts=4 fdm=indent et 
"============ indent ============


"============ encoding ============
" -- piaip's gvim settings for gvim/win32 with UTF8
" -- optimized for Traditional Chinese users
" -- last update: Mon Jun 7 17:59:54 CST 2004
" ---------------------------------
" - let $LANG="zh_TW.UTF-8" " locales
" - set fileencoding=big5 " prefer
" -  charset detect list. ucs-bom must be earlier than ucs*.
" - set fileencodings=ascii,ucs-bom,utf-8,ucs-2,ucs-le,sjis,big5,latin1
" -  for console mode we use big5
" - set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
" - if has("gui_running")
" -     set termencoding=utf-8
" - else
" -     set termencoding=big5
" - endif
" - vim:ft=vim
" ---------------------------------
    set fileencodings=ucs-bom,utf-8,big5,euc-jp,sjis,gbk,euc-kr,latin1
    "set fileencodings=utf-8,chinese,latin-1,ucs-bom,gb18030,big5,euc-jp,sjis,euc-kr,EUC
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
" menu encoding
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/mswin.vim
    "lang messages zh_TW.utf-8
" related pluging: fencview
"                  this plugin can detect file encoding method autometically.
"============ encoding ============



"============ key map ============
" convenient scroll
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>
" auto zz after jump
    nnoremap <C-o> <C-o>zz
    nnoremap <C-i> <C-i>zz
    nnoremap <C-]> <C-]>zz
" clear all highlight when redraw
    nnoremap <silent> <C-l> :nohl<CR><C-l>
"============ key map ============


"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"=-=-=-=-=-=-=-=-=-=-=-=-=      Plugin Settings      =-=-=-=-=-=-=-=-=-=-=-=-=
"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

"============ snipMate ============
" An attempt to emulate TextMate's snippet expansion 
" Just like what snippyEmu do, but better.
" See http://www.vim.org/scripts/script.php?script_id=2540
"============ snipMate ============


"============ edit Python in VIM ============
" Please install Python compiler before using this command
autocmd BufRead *.py    map <F9> :!python %<CR>
"============ edit Python in VIM ============


"============ SuperTab coninued ============
" This script allows you to use the tab key to do all your insert completion
" See http://www.vim.org/scripts/script.php?script_id=1643
"============ SuperTab coninued ============


"============ TagList ============
let Tlist_Ctags_Cmd = 'ctags'
nnoremap <F12> :TlistToggle<CR>
autocmd BufWritePost *.rb   :TlistUpdate
autocmd BufWritePost *.py   :TlistUpdate
autocmd BufWritePost *.c    :TlistUpdate
autocmd BufWritePost *.cpp  :TlistUpdate
autocmd BufWritePost *.java :TlistUpdate
" Displaying tags for only one file~
let Tlist_Show_One_File = 1
" if you are the last, kill yourself
let Tlist_Exist_OnlyWindow = 1
" split to the right side of the screen
let Tlist_Use_Right_Window = 0
" sort by order or name
let Tlist_Sort_Type = "order"
" do not show prototypes and not tags in the taglist window.
let Tlist_Display_Prototype = 0
" Remove extra information and blank lines from the taglist window.
let Tlist_Compart_Format = 0
" Jump to taglist window on open.
let Tlist_GainFocus_On_ToggleOpen = 0
" Show tag scope next to the tag name.
let Tlist_Display_Tag_Scope = 1
" Close the taglist window when a file or tag is selected.
let Tlist_Close_On_Select = 0
" Don't Show the fold indicator column in the taglist window.
let Tlist_Enable_Fold_Column = 0
"let Tlist_WinWidth = 40
"============ TagList ============


"============ Cscope ============
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB == ""
        let mysrctop = $CDIP_TOP
        let mytagpath = $CDIP_TAG_PATH
        if filereadable(mytagpath."/cscope_c.out")
            autocmd BufRead *.c    exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
            autocmd BufRead *.cpp  exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
            autocmd BufRead *.h    exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
        endif
        if filereadable(mytagpath."/cscope_j.out")
            autocmd BufRead *.java exec("cs add ".mytagpath."/cscope_j.out ".mysrctop)
        endif
        if filereadable(mytagpath."/cscope.out")
            autocmd BufRead *.java exec("cs add ".mytagpath."/cscope.out ".mysrctop)
        endif
    else
        cs add $CSCOPE_DB
    endif
endif
"============ Cscope ============


"============ ctags ============
" add any database in current directory
if filereadable("tags")
    set tag=tags
" else add database pointed to by environment
else
    let mysrctop = $CDIP_TOP
    if filereadable(mysrctop."/.cdip_tags_c")
        autocmd BufRead *.c    exec("set tag=".mysrctop."/.cdip_tags_c")
        autocmd BufRead *.cpp  exec("set tag=".mysrctop."/.cdip_tags_c")
        autocmd BufRead *.h    exec("set tag=".mysrctop."/.cdip_tags_c")
    endif
    if filereadable(mysrctop."/.cdip_tags_j")
        autocmd BufRead *.java exec("set tag=".mysrctop."/.cdip_tags_j ")
    endif
    if filereadable(mysrctop."/tags")
        set tag=mysrctop."/tags"
    endif
endif
"============ ctags ============


"============ vala support ============
autocmd BufRead,BufNewFile *.vala setfiletype vala
autocmd BufRead,BufNewFile *.vapi setfiletype vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
"============ vala support ============

