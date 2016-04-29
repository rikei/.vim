
#vundle setup
```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```

#ctags and cscope

```
ctags -I __THROW,__attribute_pure__,__nonnull,__attribute__ --langmap=c:+.h --languages=c,c++ --c-kinds=+px --c++-kinds=+px --fields=+iafksS --extra=+qf -f ~/tags_sys -R  /usr/include

find /usr/include -name "*.h" > ~/cscope_sys.files && cscope -b -i  ~/cscope_sys.files -f ~/cscope_sys.out
```

#environment setting

```
export VIM_TAGS_C=~/tags_sys
export VIM_CSCOPE_C=~/cscope_sys.out
export VIM_PATH_C=/usr/include

export VIM_GCC_OPT_C="-D_DBTYPE_DB2 "

export VIM_TAGS_PY=~/tags_py
export VIM_CSCOPE_PY=~/cscope_py.out
```
#.vimrc setting

```ln -s ~/.vim/.vimrc ~/.vimrc```
or
```cp ~/.vim/.vimrc ~/.vimrc```
