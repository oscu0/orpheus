#!/usr/bin/env bash
set -o vi
if [ -f /usr/local/etc/profile.d/z.sh ]; then
    source /usr/local/etc/profile.d/z.sh
fi
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
}

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s globstar
shopt -s histappend
shopt -s xpg_echo
alias cp='/bin/cp -i'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'
# complete -o nospace -F _cd cd
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
function idea_i () {
    for i in "$@"
    do
        idea "$(pwd)/$i" > /dev/null 2>&1
    done
}
