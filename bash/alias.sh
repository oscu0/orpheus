#!/usr/bin/env bash
# alias mvim='open -a /Applications/MacVim.app'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias clang++='clang++ -std=c++11 -Wall'
alias clang='clang -std=c11 -Wall'
alias cli_update='vim +PlugUpgrade +PlugUpdate +PlugClean! +qall && cd ~/.tmux/plugins/tpm && git pull && conda deactivate && cd && echo \Updating\ global\ packages\ && gem update && python -m pip install --upgrade pip && pip-review --local --auto && echo \Updating\ Conda\ && conda update -n base conda -y && echo \Updating\ Anaconda\ && conda activate anaconda3_env && conda update --all -y && conda deactivate && fish -c omf\ update && echo \Updating\ Homebrew\ && brew upgrade && brew cask upgrade && brew cleanup && brew cask cleanup && npm i npm -g && npm -g update && cd' # horrible
alias df='grc df -h'
alias du='grc du -h'
alias fpc='fpc -Mtp -vewl'
alias fzfs='mdfind -onlyin ~ "*" | fzf'
alias gcc='gcc -std=c11 -Wall'
alias g++='g++ -std=c++11 -Wall'
alias grep='grep --color=auto'
alias julia='/Applications/JuliaPro-0.6.2.2.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia'
alias less='less -RiJrq'
alias ls='ls -GFh'
alias motd='cat /etc/motd'
alias nasm-2.13='nasm -Wall'
alias posix='sh --posix +B && unalias -a && alias vi = vi -u NONE -U NONE -N -i NONE -c "set compatible" && clear && motd'
alias ql='qlmanage -p 2>/dev/null'
alias rsync='rsync -Kath --progress'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias tmux='tmux -2'
alias tree='tree -C'
export LESS="-iMFXR"
math='/Applications/Mathematica.app/Contents/MacOS/WolframKernel'
dash() {
    open "dash://$1"
}

e() {
    # open -a /Applications/Emacs.app "$@" --args --chdir "$PWD"
    open -a /Applications/Emacs.app "$@"
}
