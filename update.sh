#!/bin/bash
# Get changes in config files by simply copying them all here.
# Differences can then be checked with git diff

ROUTEFILE=files.txt

function update {
    echo "Copying $1 to $2"
    cp -r $1 $2
}

FILES=($(cat $ROUTEFILE))
L=${#FILES[@]}

i="0"

while [ $i -lt $L ]; do
    update $HOME/${FILES[i]} ${FILES[i+1]}
    i=$[$i+2]
done

#  Special case for .vim
cp -r $HOME/.vim/ $HOME/vim/
update $HOME/vim/ . 
rm -rf $HOME/vim/

echo "Config files updated."
