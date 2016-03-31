1.ctags and cscope

ctags -I __THROW,__attribute_pure__,__nonnull,__attribute__ --langmap=c:+.h --languages=c,c++ --c-kinds=+px --c++-kinds=+px --fields=+iafksS --extra=+qf -f ~/tags_sys -R  /usr/include

find /usr/include -name "*.h" > ~/cscope_sys.files && cscope -b -i  ~/cscope_sys.files -f ~/cscope_sys.out

2.environment setting, for example:

export VIM_TAGS_C=~/tags_sys

export VIM_CSCOPE_C=~/cscope_sys.out

export VIM_PATH_C=/usr/include

export VIM_GCC_OPT_C="-D_DBTYPE_DB2 "

export VIM_TAGS_PY=~/tags_py

export VIM_CSCOPE_PY=~/cscope_py.out

3..vimrc setting

ln -s ~/.vim/.vimrc ~/.vimrc

cp ~/.vim/.vimrc ~/.vimrc
