#!/bin/bash
# Just copy the config files to where they should go

function install {
    echo "Copying $1 to $2"
    cp -r $1 $2
}

# .vim
cp -r vim/ .vim/
install .vim/ $HOME/
rm -rf .vim/

install vim/.vimrc $HOME/.vimrc

# .bashrc
install bashrc $HOME/.bashrc

# .toprc
install toprc $HOME/.toprc

# .screenrc
install screenrc $HOME/.screenrc

# matplotlibrc
install matplotlibrc $HOME/.config/matplotlib/matplotlibrc


echo "Config files installed."
