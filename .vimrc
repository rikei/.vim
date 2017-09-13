" => Sections{{{
"    => Sections{{&filetype{
"    => Vundle setting
"    => General
"    => VIM user interface
"    => Colors and Fonts
"    => Files and backups
"    => Text, tab and indent related
"    => Visual mode related
"    => Moving around, tabs and buffers
"    => Status line
"    => Vimgrep searching and cope displaying
"    => Spell checking
"    => Misc
"    => Persional setting
"    => Language special
"    => Custom-defined function and commands
"    => Plugin setting
"}}}

"=> Vundle setting{{{
set nocompatible

if "" != finddir('Vundle.vim', $HOME.'/.vim/bundle')
    filetype off
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    "general
    Plugin 'rikei/vim-colorschemes'
    Plugin 'jdevera/vim-cs-explorer'
    Plugin 'rikei/misc.vim'
    Plugin 'rikei/syntastic'
    Plugin 'taglist.vim'
    Plugin 'omnicppcomplete'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'SingleCompile'
    Plugin 'skywind3000/asyncrun.vim'
    Plugin 'DoxygenToolkit.vim'

    call vundle#end()
    filetype plugin indent on "required
endif
"}}}

" => General{{{
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"set help language
set helplang=en

"how to express the difference with two files
set diffopt=filler,context:3,vertical

"popup confirm message when save unsaved or read-only files
set confirm

"set language as english by force
set langmenu=none

if "" != findfile("delmenu.vim",$VIMRUNTIME)
    source $VIMRUNTIME/delmenu.vim
endif

if "" != findfile("menu.vim",$VIMRUNTIME)
    source $VIMRUNTIME/menu.vim
endif

language messages C
language time C

"set terminal encoding
let &termencoding=&encoding

"set fileencodings list
se fencs=ucs-bom,cp936,utf-8,cp932,latin1

"set fenc to encoding if fenc is not specific
"for empty file
au  BufNewFile * let &fenc=&encoding

" Use Unix as the standard file type
set ffs=unix,dos,mac

set nostartofline

set ve=block

"set clipboard=unnamed
"}}}

" => VIM user interface{{{
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"show line number
set number
set numberwidth=5

"do't show the startup message of help the children
set shortmess=atIoO

"set text width
set textwidth=9999
"set colorcolumn+=1

"characters that form pairs
set mps+=<:>

"show command
set showcmd

"highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline

"fold setting
if has("folding")
    set foldenable
    "set foldmethod=syntax
    set foldcolumn=3
    set foldlevel=0
    "set foldclose=all
    nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
endif

"enable mouse
"set mouse=a

"}}}

" => Colors and Fonts{{{
" Enable syntax highlighting
syntax enable

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=e
    set guioptions+=c
    set guitablabel=%M\ %t
    set guifont=Consolas:h12:cANSI

    set t_Co=256
    try
        colorscheme desert
    catch
        colorscheme desert
    endtry
else
    set t_Co=256
    try
        colorscheme desert
    catch
        colorscheme desert
    endtry
endif
"}}}

" => Files, backups and undo{{{
if has("writebackup")
    if "" == finddir('.backup', $HOME.'/.vimws')
        call mkdir($HOME.'/.vimws/.backup','p')
    endif

    augroup file_backup
        au Filetype c,cpp,make,sh,vim
                    \ setlocal backup |
                    \ setlocal backupdir=$HOME/.vimws/.backup |
                    \ let &bex = '_' . strftime("%Y%m%d_%H%M")
    augroup END
endif

if has("mksession")
    set ssop-=curdir
    set ssop+=sesdir
endif

set dir=$HOME/.vimws/.swap
if "" == finddir('.swap', $HOME.'/.vimws')
    call mkdir($HOME.'/.vimws/.swap','p')
endif

if has('persistent_undo')      "check if your vim version supports it
    set undofile                 "turn on the feature
    set undodir=$HOME/.vimws/.undo  "directory where the undo files will be stored
    if "" == finddir('.undo', $HOME.'/.vimws')
        call mkdir($HOME.'/.vimws/.undo','p')
    endif
endif

au BufNewFile,BufRead *.pc setfile c
au BufNewFile,BufRead *.sqc setfile c
au BufNewFile,BufRead *.CFG setfile sql
au BufNewFile,BufRead *.jrxml setfile sql
"}}}

" => Text, tab and indent related{{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set nowrap "Wrap lines

"show space betterly when use command 'se list'
set listchars=tab:>-,eol:$,nbsp:%,trail:.,extends:>,precedes:<

"visual map setting
vmap F :s/\%V\s*//<CR>

"copy text
vmap <C-c> "+y

vnoremap < <gv
vnoremap > >gv

"}}}

" => Moving around, tabs, windows and buffers{{{
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo=%100,'100,/100,:100,<100,s100,@100

au! BufWritePost .vimrc source %

if exists("+autochdir")
    set autochdir
endif
"}}}

" => Status line{{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ |
"}}}

" => Misc{{{
" remvoe all the trailling whitespaces
nnoremap <silent> <leader>W :%s/\s\+$//e<cr>:let @/=''<cr>

"auto full screen
au GUIEnter * simalt ~x
"}}}

" => Persional setting{{{
iabbrev teh the
iabbrev itn int
iabbrev cahr char
iabbrev form from
iabbrev mian main
"}}}

" => Language special{{{
augroup ft_c
    au FileType c,cpp
                \ setlocal iskeyword-=- |
                \ match Error /\s\+$/
augroup END

augroup ft_make
    au FileType make
                \ setlocal isfname+=(,) |
                \ setlocal includeexpr=substitute(v:fname,'$(\\(\\w*\\))','$\\1','g') |
                \ match Error /\s\+$/
augroup END

augroup ft_sh
    au FileType sh
                \ setlocal isfname+={,} |
                \ setlocal isk-=$ |
                \ match Error /\s\+$/
augroup end

augroup ft_perl
    au FileType perl
                \ setlocal iskeyword+=-,$,@,%,# |
                \ match Error /\s\+$/
augroup END

augroup ft_python
    au FileType python
                \ match Error /\s\+$/
augroup END

augroup ft_sql
    au FileType sql
                \ match Error /\s\+$/
augroup END

"}}}

" => Custom-defined function and commands{{{
"}}}

" => Plugin setting{{{
"plugin - taglist.vim{{{
let Tlist_Ctags_Cmd = 'ctags'

let Tlist_Show_One_File = 1            "not show the tag of more than one files,just show the current one
let Tlist_Exit_OnlyWindow = 1          "if the taglist window is the last window,then exit vim
let Tlist_File_Fold_Auto_Close=1       "auto fold the function list that is not editing
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 0
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
"let Tlist_Auto_Open=1    "open taglist when start vim
let Tlist_Sort_Type = "name"
"sort by name
let Tlist_Use_Right_Window = 0    "show window at right
let Tlist_Compart_Format = 1
"compress format
let Tlist_Exist_OnlyWindow = 1
"when has only one buffer,kill window and buffer
let Tlist_File_Fold_Auto_Close = 0
"tagsdo't close the tags that belongs to other files
let Tlist_Enable_Fold_Column = 0
"not show fold tree
"nmap <silent><F7> :Tlist<cr>
"}}}

" plugin - OmniCppComplete setting{{{
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 "show function prototype
let OmniCpp_MayCompleteDot = 0   "input ., auto complete
let OmniCpp_MayCompleteArrow = 0 "input ->, auto complete
let OmniCpp_MayCompleteScope = 0 "input :: auto complete
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"auto close complete window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

"color setting
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black
"}}}

"plugin - syntastic{{{
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_python_checkers=['pyflakes']

" to see error location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_loc_list_height = 5

let g:syntastic_c_compiler_options = $VIM_MISC_GCC_OPT_C
if "" != $VIM_MISC_PATH_C
    for path in split($VIM_MISC_PATH_C, ',\| ')
        let g:syntastic_c_compiler_options .= " -I".path
    endfor
endif
"}}}

"plugin - SingleCompile{{{
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
"}}}

" plugin - dummy{{{
"autocmd BufCreate * if "" == expand("%") | cd ~ | endif
"}}}
" vim: set fdm=marker:
"}}}
