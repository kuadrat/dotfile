alias rm='rm -i'
alias ls='ls $LSCOLOR --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# Copy pasting
alias c="xclip"
alias v="xclip -o"
alias pwdc="pwd|c"
alias cdv='cd `v`'

# ssh
alias ussh="ssh -2Y kekram@linux.physik.uzh.ch"
function pscp() {
    echo "Sending $1 to Physik server..."
    scp -i ~/.ssh/id_ed25519 $1 kekram@linux.physik.uzh.ch:~
}
