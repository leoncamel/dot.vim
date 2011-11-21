
Prerequires
-----------
    1. global-5.9.5 or later
    2. ruby for command-t.git

Install
-------

    git clone gitolite@localhost:dot.vim.git

    ln -s dot.vim $HOME/.vim
    ln -s dot.vim/vimrc $HOME/.vimrc

    git submodule init
    git submodule update

    cd bundle/command-t/ruby/command-t/
    ruby extconf.rb
    make

Add submodule
-------------
    1. for example:

    git submodule add git://github.com/xxx/your-submodule.git bundle/your-submodule-path.git

TODO
----

    1. config the "csindent.vim" plugin
    2. try clewn or pyclewn


