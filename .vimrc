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
"    => Environment setting
"    => Persional setting
"    => Language special
"    => Custom-defined function and commands
"    => plugin setting
"}}}

"=> Vundle setting{{{
set nocompatible

if "" != finddir('Vundle.vim', $HOME.'/.vim/bundle')
    filetype off
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
    call vundle#begin()

    "general
    Plugin 'scrooloose/nerdtree'

    Plugin 'flazz/vim-colorschemes'
    Plugin 'jdevera/vim-cs-explorer'

    Plugin 'scrooloose/syntastic'
    Plugin 'SingleCompile'
    Plugin 'DoxygenToolkit.vim'
    Plugin 'taglist.vim'

    " c
    Plugin 'omnicppcomplete'
    Plugin 'echofunc.vim'

    " python
    Plugin 'pythoncomplete'
    Plugin 'pydiction'

    " markdown
    Plugin 'plasticboy/vim-markdown'

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
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_US.utf-8

"set terminal encoding
let &termencoding=&encoding

"set encodings
"se encoding=utf-8
"se encoding=cp936

"set fileencodings list
se fencs=ucs-bom,cp936,utf-8,cp932,latin1

" Use Unix as the standard file type
set ffs=unix,dos,mac

set nostartofline
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
"set cursorline cursorcolumn

"fold setting
if has("folding")
    set foldenable
    "set foldmethod=syntax
    set foldcolumn=3
    set foldlevel=0
    "set foldclose=all
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
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
    set guioptions+=e
    set guitablabel=%M\ %t
    set guifont=Consolas:h12:cANSI

    set t_Co=256
    try
        colorscheme solarized
    catch
        colorscheme desert
    endtry
else
    set t_Co=256
    try
        colorscheme molokai
    catch
        colorscheme desert
    endtry
endif
"}}}

" => Files, backups and undo{{{
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
"set noswapfile

au BufNewFile,BufRead *.pc setfile c
au BufNewFile,BufRead *.sqc setfile c
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
set si "Smart indent
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
" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk

" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
"map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fullpath
map <leader>f :echo expand("%:p")<cr>

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
set viminfo^=%

au! BufWritePost .vimrc source %
"}}}

" => Status line{{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
"}}}

" => Misc{{{
" Quickly open a buffer for scripbble
"map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" remvoe all the trailling whitespaces
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<cr>

" replace tab with space
nnoremap <leader>T :%s/\t/    /ge<cr>:let @/=''<cr>

"auto full screen
au GUIEnter * simalt ~x

"au VimResized * exe "normal! \<c-w>="

map q: :q

" make tags for current directory
map <F3> <ESC>:!ctags --fields=+iafksS --extra=+qf -R *<cr>
"}}}

" => Environment setting{{{

"}}}

" => Persional setting{{{
iabbrev teh the
iabbrev itn int
iabbrev cahr char
iabbrev form from
iabbrev mian main
"iabbrev time <c-r>=strftime("%Y/%m/%d %X")<CR>
"iabbrev date <c-r>=strftime("%Y/%m/%d")<CR>
"}}}

" => Language special{{{
augroup ft_c
    au FileType c,cpp
                \ setlocal iskeyword-=- |
                \ match Error /\s\+$/ |
                \ call SetCEnv()
    au BufNewFile *.{c,cpp,h}
                \ call SetTitle()
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
    au BufNewFile *.sh
                \ call SetTitle()
augroup end

augroup ft_perl
    au FileType perl
                \ setlocal iskeyword+=-,$,@,%,# |
                \ match Error /\s\+$/
augroup END

augroup ft_python
    au FileType python
                \ setlocal ts=4 |
                \ setlocal sts=4 |
                \ setlocal sw=4 |
                \ setlocal et |
                \ setlocal ai |
                \ setlocal ff=unix |
                \ inoremap # X#|
                \ match Error /\s\+$/ |
                \ call SetPyEnv()
    au BufNewFile *.py
                \ call SetTitle()
augroup END

augroup ft_sql
    au FileType sql
                \ match Error /\s\+$/
    au BufNewFile *.sql
                \ call SetTitle()
augroup END

"}}}

" => Custom-defined function and commands{{{
" comment leader
au FileType haskell,vhdl,ada,sql
            \ let b:comment_leader = '-- '
au FileType vim
            \ let b:comment_leader = '" '
au FileType c,cpp,java
           \ let b:comment_leader = '// '
au FileType sh,make,perl,python
            \ let b:comment_leader = '# '
au FileType tex
            \ let b:comment_leader = '% '

" set titile
func! SetTitle ()
    let s:title=""

    " shabang
    if "sh" == &ft
        let s:title .= "#!/bin/env bash\r"
    elseif "python" ==&ft
        let s:title  = "#!/bin/env python\r"
        let s:title .= "# -*- coding: utf-8 -*-\r"
    endif

    " body
    let s:title .= b:comment_leader."==========================================================\r"
    let s:title .= b:comment_leader." File          : ".expand("%:t")."\r"
    let s:title .= b:comment_leader." Author        :\r"
    let s:title .= b:comment_leader." Description   : xxxxxx\r"
    let s:title .= b:comment_leader." Last Modified : ".strftime("%Y %b %d %X") ."\r"
    let s:title .= b:comment_leader."==========================================================\r"

    call append(0, s:title)
    exe "1s//\r/g"
endfunc

" set tags and cscope
func! SetCEnv()
    if has("path_extra")
        if "" != $VIM_PATH_C
            for path in split($VIM_PATH_C, ',\| ')
                exec "set path+=".path
            endfor
        endif
    endif

    if has("emacs_tags")
        if "" != $VIM_TAGS_C
            for tag in split($VIM_TAGS_C, ',\| ')
                exec "set tags+=".tag
            endfor
        endif
    endif

    "cscope -b
    if has("cscope")
        "set csprg=/usr/cscope
        set csto=1
        set cst
        "set cscopequickfix=s-,c-,d-,i-,t-,e-
        set nocsverb

        if "" != $VIM_CSCOPE_C
            for cscope in split($VIM_CSCOPE_C, ',\| ')
                exec "cs add ".cscope
            endfor
        endif

        set csverb
    endif
endfunc

" set tags and cscope
func! SetPyEnv()
    if has("emacs_tags")
        if "" != $VIM_TAGS_PY
            for tag in split($VIM_TAGS_PY, ',\| ')
                exec "set tags+=".tag
            endfor
        endif
    endif

    if has("cscope")
        "set csprg=/usr/cscope
        set csto=1
        set cst
        "set cscopequickfix=s-,c-,d-,i-,t-,e-
        set nocsverb

        if "" != $VIM_CSCOPE_PY
            for cscope in split($VIM_CSCOPE_PY, ',\| ')
                exec "cs add ".cscope
            endfor
        endif

        set csverb
    endif
endfunc

com! -range -nargs=0 Comment call Comment(<line1>, <line2>)
com! -range -nargs=0 Uncomment call Uncomment(<line1>, <line2>)

"Function for commenting a block of Visually selected text
func! Comment(start, end)
  let i=a:start
  while i<=a:end
    let cl=getline(i)
    let cl2=b:comment_leader.cl
    call setline(i, cl2)
    let i=i+1
  endwhile
endfunction

"Function for Un-Commenting a block of Visually selected text
func! Uncomment(start, end)
  let i=a:start
  while i<=a:end
    let cl=getline(i)
    let cl2=substitute(cl, b:comment_leader, "", "")
    call setline(i, cl2)
    let i=i+1
  endwhile
endfunction
"}}}

" => plugin setting{{{
"plugin - taglist.vim{{{
""view function list, ctags  programme is needed
"F4 show hidden taglist window
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
nmap <silent><F7> :Tlist<cr>
"}}}

" plugin - OmniCppComplete setting{{{
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 "show function prototype
let OmniCpp_MayCompleteDot = 1   "input ., auto complete
let OmniCpp_MayCompleteArrow = 1 "input ->, auto complete
let OmniCpp_MayCompleteScope = 1 "input :: auto complete
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"auto close complete window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

"color setting
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black
"}}}

" plugin - DoxygenToolkit.vim{{{
"          comments,and generate standard function comments quickly
"let g:DoxygenToolkit_authorName="rikei(rikei.orz@gmail.com)"
let g:DoxygenToolkit_licenseTag="My own license\<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief\t"
let g:DoxygenToolkit_paramTag_pre = "@param\t"
let g:DoxygenToolkit_returnTag = "@return\t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30

map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
"}}}

"plugin - snipMate{{{
let g:snips_author = 'lipan'
"}}}

"plugin - vim_markdown{{{
let g:vim_markdown_folding_disabled = 1
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

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <Leader>s :call ToggleErrors()<cr>
"nnoremap <Leader>sn :lnext<cr>
"nnoremap <Leader>sp :lprevious<cr>

let g:syntastic_c_compiler_options = $VIM_GCC_OPT_C
if "" != $VIM_PATH_C
    for path in split($VIM_PATH_C, ',\| ')
        let g:syntastic_c_compiler_options .= " -I".path
    endfor
endif
"}}}

"plugin - pydiction{{{
let g:pydiction_location = $HOME.'/.vim/bundle/pydiction/complete-dict'
"}}}

"plugin - SingleCompile{{{
map <silent> <leader>r <ESC>:SCCompileRun<CR>
map <silent> <F5> <ESC>:SCCompileRun<CR>
"}}}

"plugin - echofunc.vim{{{
let g:EchoFuncAutoStartBalloonDeclaration=1
let g:EchoFuncKeyPrev='<c-b>'
let g:EchoFuncKeyNext='<c-f>'
let g:EchoFuncLangsUsed = ["c","cpp","python"]  
"}}}
" vim: set fdm=marker:
"}}}
