# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/home/kevin/Programme/bin/vim
#export EDITOR=/home/kevin/Programme/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

# Begruessung
KBOX=(
"\e[36m     ___    \e[94m   ___          ___          ___          ___     "
"\e[36m    /\__\   \e[94m  /\  \        /\  \        /\  \        /\__\    "
"\e[36m   /:/  /   \e[94m  \:\  \      /::\  \      /::\  \      /::|  |   "
"\e[36m  /:/__/    \e[94m   \:\  \    /:/\:\  \    /:/\:\  \    /:|:|  |   "
"\e[36m /::\__\____\e[94m   /::\  \  /::\~\:\  \  /::\~\:\  \  /:/|:|__|__ "
"\e[36m/:/\:::::\__\ \e[94m/:/\:\__\/:/\:\ \:\__\/:/\:\ \:\__\/:/ |::::\__\ "
"\e[36m\/_|:|~~|~~~/\e[94m/:/  \/__/\:\~\:\ \/__/\/_|::\/:/  /\/__/~~/:/  /"
"\e[36m   |:|  |  \e[94m /:/  /      \:\ \:\__\     |:|::/  /       /:/  / "
"\e[36m   |:|  |  \e[94m \/__/        \:\ \/__/     |:|\/__/       /:/  /  "
"\e[36m   |:|  |  \e[94m               \:\__\       |:|  |        /:/  /   "
"\e[36m    \|__|  \e[94m                \/__/        \|__|        \/__/    "
)

KEY=(
"              .,,,."
"           .;;;;;;;;;,"
"          ;;;'    \`;;;,"
"         ;;;'      \`;;;"
"         ;;;        ;;;"
"         ;;;.      ;;;'"
"         \`;;;.    ;;;'"
"          \`;;;.  ;;;'"
"           \`;;',;;'"
"            ,;;;'"
"         ,;;;',;' ...,,,,..."
"      ,;;;'    ,;;;;;;;;;;;;;;,"
"   ,;;;'     ,;;;;;;;;;;;;;;;;;;,"
"  ;;;;'     ;;;',,,   \`';;;;;;;;;;"
" ;;;;,      ;;   ;;;     ';;;;;;;;;"
";;;;;;       '    ;;;      ';;;;;;;"
";;;;;;            .;;;      ;;;;;;;"
";;;;;;,            ;;;;     ;;;;;;'"
" ;;;;;;,            ;;;;   .;;;;;'"
"  \`;;;;;;,           ;;;; ,;;;;;'"
"   \`;;;;;;;,,,,,,,,,, ;;;; ;;;'"
"      \`;;;;;;;;;;;;;;; ;;;; '"
"          ''''''''''''' ;;;."
"               .;;;.    \`;;;."
"              ;;;; '     ;;;;"
"              ;;;;,,,..,;;;;;"
"              \`;;;;;;;;;;;;;'"
"                \`;;;;;;;;;'"
)

 
# Check if we're running a screen session and change the prompt accordingly
if [ $WINDOW ]; then
    # Prompt that shows host, useful for remote machines:
    export PS1='\[\e[38;5;226m\][SCREEN:\[\e[1m\]${WINDOW}\[\e[0;38;5;226m\]]\[\e[38;5;26m\]\w \$ \[\e[m\]'
    alias ls='ls --color=auto'
else    
    # Define the custom prompt for regular bash sessions
    # Changes color depending on number of open terminals
    PS1COLORS=( 14 10 11 13 )
    COLOR=$( echo $(who | wc -l) % ${#PS1COLORS[@]} | bc )
    export PS1="\[\e[38;5;"${PS1COLORS[$COLOR]}"m\]\w \$ \[\e[m\]"

    # Send a greeting message
    # Determine which message is displayed randomly
    if (( $(echo $RANDOM % 2 | bc) )); then
        MESSAGE=( "${KEY[@]}" )
    else
        MESSAGE=( "${KBOX[@]}" )
    fi

    COLORS=(35 95 94 34 36 96 92 32 93 33 91 31)
    I=0
    N=${#COLORS[@]}
    for line in "${MESSAGE[@]}"; do
        echo -e "\e["${COLORS[(($I%$N))]}";2m$line\e[m"
        I=$(echo $I+1 | bc)
    done
   # export PS1='\[\e[38;5;11m\][\h]\[\e[38;5;1m\] \w \$ \[\e[m\]'
fi



# mongoDB binaries einbinden

#export PATH="/home/kevin/Programme/mongoDB/mongodb-linux-x86_64-2.6.6/bin/:$PATH"

# config file for mri-pet web application development
#export SAFIR_CONFIG_FILE="/home/kevin/Dokumente/safir/local_config.py"

# When using su to login as root, the right .bashrc or .profile aren't read - 
# this works, however with "su -"
alias su="su -"

# Zeitsparer
alias ..="cd .."
alias cdq="cd ~/Documents/qmap"

# ssh shortcuts
PHYS_KEY="~/.ssh/id_rsa_physik"
export PHYS_KEY
alias unissh="ssh -i $PHYS_KEY -2Y kekram@linux.physik.uzh.ch"
function ussh { ssh -i $PHYS_KEY -Y kekram@"$1".physik.uzh.ch; }
export -f ussh
alias pscp="scp -i $PHYS_KEY"

ethssh="ssh kramerk@login.phys.ethz.ch"
alias safirssh="ssh -fN -l root -L 9999:localhost:27017 mri-pet.ethz.ch"
function pceth { ssh -Y mri-pet@pceth"$1".cern.ch; }
export -f pceth
alias blade="ssh -Y kkramer@bladeethg41.cern.ch"
alias monch="ssh -Y kramerk@ela.cscs.ch"

alias ela="ssh -Y stud05@ela.cscs.ch"

# vpn shortcut
alias ethvpn="/opt/cisco/anyconnect/bin/vpn connect sslvpn.ethz.ch/"


# Copy pasting
alias c="xclip"
alias v="xclip -o"
alias pwdc="pwd|c"
alias cdv='cd `v`'

# Sicherheit beim Loeschen
alias rm="rm -i"

# Shell funktion um alle Bilder eines Typs rasch zu öffnen
function gwall {
    if [ ! "$1" ]
    then
        arg="*.png"
    else
        arg="$1"
    fi
    echo "$arg"
    echo "Starting gwenview $arg &"
    gwenview $arg &
}

# beep is aliased in /etc/profile.d/alias.bash - but I want the beep program
#unalias beep

# Programme aus Terminal
#alias eclipse="/home/kevin/Eclipse/eclipse/eclipse"
#alias ts3="/home/kevin/Programme/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh"

# Enable 256 color support
export TERM="xterm-256color"

# temporarily add MT scripts
#PATH="/home/kevin/Documents/uni/master_thesis/data/scripts:${PATH}"
# temporrily add MT python modules
#PYTHONPATH="${PYTHONPATH}:/home/kevin/uni/master_thesis/data/scripts/Python_APIS"

# Add QMAP scripts
ANALYSIS="/home/kevin/Documents/qmap/analysis/"
ARPYS="/home/kevin/bin/arpys/"
PYTHONPATH="${PYTHONPATH}:$ANALYSIS/w2k:$ARPYS:$ARPYS/tools"
PATH="$ARPYS:$ARPYS/tools:${PATH}"

PYTHONPATH="${PYTHONPATH}:/home/kevin/bin/"
export PYTHONPATH
export PATH

# For pyqtgraph+PyQt5
PYQTGRAPH_QT_LIB='PyQt5'
export PYQTGRAPH_QT_LIB

#PATH="/home/kevin/perl5/bin:$PATH"; export PATH;
PERL5LIB="/home/kevin/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kevin/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
