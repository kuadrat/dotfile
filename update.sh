#!/bin/bash
# Get changes in config files by simply copying them all here.
# Differences can then be checked with git diff

function update {
    echo "Copying $1 to $2"
    cp -r $1 $2
}

# .vim
cp -r $HOME/.vim/ $HOME/vim/
update $HOME/vim/ . 
rm -rf $HOME/vim/

update $HOME/.vimrc ./vim

# .bashrc
update $HOME/.bashrc ./bashrc

# .toprc
update $HOME/.toprc ./toprc

echo "Config files updated."
