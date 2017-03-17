#!/bin/bash
# Just copy the config files to where they should go

ROUTEFILE=files.txt

function install {
    echo "Copying $1 to $2"
    cp -r $1 $2
}

# Get destinations and locations from a routefile
FILES=($(cat $ROUTEFILE))
L=${#FILES[@]}

i="0"

# Update all files specified in the ROUTEFILE
while [ $i -lt $L ]; do
    install ${FILES[i+1]} $HOME/${FILES[i]}
    i=$[$i+2]
done

# Special case for  .vim
cp -r vim/ .vim/
install .vim/ $HOME/
rm -rf .vim/

echo "Config files installed."
