" VIM syntax file for Geant4 and GATE .mac files
" Language: Geant4
" Maintainer: Kevin Kramer
" Latest Revision 04 July 2015

" Check if other syntax file is already loaded
if exists("b:current_syntax")
    finish
endif

" define keywords
syntax keyword Keyword execute alias

" define different regions
syntax match macroComment "#.*$"
syntax match macroTitle "^#[^#]*#"
syntax match macroCommand "^/[^ ]\{,80}" nextgroup=macroValue skipwhite contains=Keyword
syntax match macroValue " .*$" contains=macroVariable,macroNumber,macroComment
syntax match macroVariable "{.*}"

" numerals : int, signed int, float, signed float
syntax match macroNumber "\s\d\+"
syntax match macroNumber "\s[-+]\d\+"
syntax match macroNumber "\s\d\+[.e]\d*[e]\=\d*"
syntax match macroNumber "\s[-+]\d\+[.e]\d*[e]\=\d*"


" define appearance of keywords & regions
hi Keyword ctermfg=Yellow
hi macroTitle ctermfg=Green cterm=none
hi macroComment ctermfg=LightGreen 
"cterm=italic
hi macroCommand ctermfg=white cterm=bold
hi macroValue ctermfg=blue
hi macroVariable ctermfg=cyan
hi macroNumber ctermfg=DarkMagenta cterm=bold


