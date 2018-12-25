export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
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


# alias mvim='open -a /Applications/MacVim.app'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias clang++='clang++ -std=c++11 -Wall'
alias clang='clang -std=c11 -Wall'
alias cli_update='vim +PlugUpgrade +PlugUpdate +PlugClean! +qall && cd ~/.tmux/plugins/tpm && git pull && conda deactivate && cd && echo \Updating\ global\ packages\ && gem update && python -m pip install --upgrade pip && pip-review --local --auto && echo \Updating\ Conda\ && conda update -n base conda -y && echo \Updating\ Anaconda\ && conda activate anaconda3_env && conda update --all -y && conda deactivate && fish -c omf\ update && echo \Updating\ Homebrew\ && brew upgrade && brew cask upgrade && brew cleanup && brew cask cleanup && npm i npm -g && npm -g update && cd' # horrible
alias df='grc df -h'
alias du='grc du -h'
alias fpc='fpc -Mtp -vewl'
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
alias tmux='tmux -2'
alias tree='tree -C'
export LESS="-iMFXR"

if [ -x "$(command -v grc)" ]; then
    # alias grc='grc --colour=on'
    if [ -x "$(command -v ant)" ]; then alias ant='grc ant'; fi
    if [ -x "$(command -v blkid)" ]; then alias blkid='grc blkid'; fi
    if [ -x "$(command -v configure)" ]; then alias configure='grc configure'; fi
    if [ -x "$(command -v cvs)" ]; then alias cvs='grc cvs'; fi
    if [ -x "$(command -v df)" ]; then alias df='grc df'; fi
    if [ -x "$(command -v diff)" ]; then alias diff='grc diff'; fi
    if [ -x "$(command -v dig)" ]; then alias dig='grc dig'; fi
    if [ -x "$(command -v dnf)" ]; then alias dnf='grc dnf'; fi
    if [ -x "$(command -v docker)" ]; then alias docker='grc docker'; fi
    if [ -x "$(command -v dockerimages)" ]; then alias dockerimages='grc dockerimages'; fi
    if [ -x "$(command -v dockerinfo)" ]; then alias dockerinfo='grc dockerinfo'; fi
    if [ -x "$(command -v dockernetwork)" ]; then alias dockernetwork='grc dockernetwork'; fi
    if [ -x "$(command -v dockerps)" ]; then alias dockerps='grc dockerps'; fi
    if [ -x "$(command -v dockerpull)" ]; then alias dockerpull='grc dockerpull'; fi
    if [ -x "$(command -v dockersearch)" ]; then alias dockersearch='grc dockersearch'; fi
    if [ -x "$(command -v dockerversion)" ]; then alias dockerversion='grc dockerversion'; fi
    if [ -x "$(command -v du)" ]; then alias du='grc du'; fi
    if [ -x "$(command -v df)" ]; then alias df='grc df'; fi
    if [ -x "$(command -v esperanto)" ]; then alias esperanto='grc esperanto'; fi
    if [ -x "$(command -v fdisk)" ]; then alias fdisk='grc fdisk'; fi
    if [ -x "$(command -v findmnt)" ]; then alias findmnt='grc findmnt'; fi
    if [ -x "$(command -v free)" ]; then alias free='grc free'; fi
    if [ -x "$(command -v gcc)" ]; then alias gcc='grc gcc'; fi
    if [ -x "$(command -v getfacl)" ]; then alias getfacl='grc getfacl'; fi
    if [ -x "$(command -v getsebool)" ]; then alias getsebool='grc getsebool'; fi
    if [ -x "$(command -v head)" ]; then alias head='grc --colour=auto head'; fi
    if [ -x "$(command -v id)" ]; then alias id='grc id'; fi
    if [ -x "$(command -v ifconfig)" ]; then alias ifconfig='grc ifconfig'; fi
    if [ -x "$(command -v iostat)" ]; then alias iostat_sar='grc iostat_sar'; fi
    if [ -x "$(command -v ip)" ]; then alias ip='grc ip'; fi
    if [ -x "$(command -v ipaddr)" ]; then alias ipaddr='grc ipaddr'; fi
    if [ -x "$(command -v ipneighbor)" ]; then alias ipneighbor='grc ipneighbor'; fi
    if [ -x "$(command -v iproute)" ]; then alias iproute='grc iproute'; fi
    if [ -x "$(command -v iptables)" ]; then alias iptables='grc iptables'; fi
    if [ -x "$(command -v irclog)" ]; then alias irclog='grc irclog'; fi
    if [ -x "$(command -v iwconfig)" ]; then alias iwconfig='grc iwconfig'; fi
    if [ -x "$(command -v last)" ]; then alias last='grc last'; fi
    if [ -x "$(command -v ldap)" ]; then alias ldap='grc ldap'; fi
    if [ -x "$(command -v log)" ]; then alias log='grc log'; fi
    if [ -x "$(command -v lolcat)" ]; then alias lolcat='grc lolcat'; fi
    if [ -x "$(command -v lsattr)" ]; then alias lsattr='grc lsattr'; fi
    if [ -x "$(command -v lsblk)" ]; then alias lsblk='grc lsblk'; fi
    if [ -x "$(command -v lsmod)" ]; then alias lsmod='grc lsmod'; fi
    if [ -x "$(command -v lsof)" ]; then alias lsof='grc lsof'; fi
    if [ -x "$(command -v lspci)" ]; then alias lspci='grc lspci'; fi
    if [ -x "$(command -v mount)" ]; then alias mount='grc mount'; fi
    if [ -x "$(command -v mtr)" ]; then alias mtr='grc mtr'; fi
    if [ -x "$(command -v mvn)" ]; then alias mvn='grc mvn'; fi
    if [ -x "$(command -v netstat)" ]; then alias netstat='grc netstat'; fi
    if [ -x "$(command -v nmap)" ]; then alias nmap='grc nmap'; fi
    if [ -x "$(command -v ntpdate)" ]; then alias ntpdate='grc ntpdate'; fi
    if [ -x "$(command -v php)" ]; then alias php='grc php'; fi
    if [ -x "$(command -v ping2)" ]; then alias ping2='grc ping2'; fi
    if [ -x "$(command -v ping)" ]; then alias ping='grc ping'; fi
    if [ -x "$(command -v proftpd)" ]; then alias proftpd='grc proftpd'; fi
    if [ -x "$(command -v ps)" ]; then alias ps='grc ps'; fi
    if [ -x "$(command -v pv)" ]; then alias pv='grc pv'; fi
    if [ -x "$(command -v semanageboolean)" ]; then alias semanageboolean='grc semanageboolean'; fi
    if [ -x "$(command -v semanagefcontext)" ]; then alias semanagefcontext='grc semanagefcontext'; fi
    if [ -x "$(command -v semanageuser)" ]; then alias semanageuser='grc semanageuser'; fi
    if [ -x "$(command -v sensors)" ]; then alias sensors='grc sensors'; fi
    if [ -x "$(command -v showmount)" ]; then alias showmount='grc showmount'; fi
    if [ -x "$(command -v sql)" ]; then alias sql='grc sql'; fi
    if [ -x "$(command -v ss)" ]; then alias ss='grc ss'; fi
    if [ -x "$(command -v stat)" ]; then alias stat='grc stat'; fi
    if [ -x "$(command -v sysctl)" ]; then alias sysctl='grc sysctl'; fi
    if [ -x "$(command -v systemctl)" ]; then alias systemctl='grc systemctl'; fi
    if [ -x "$(command -v tail)" ]; then alias tail='grc --colour=auto tail'; fi
    if [ -x "$(command -v tcpdump)" ]; then alias tcpdump='grc tcpdump'; fi
    if [ -x "$(command -v traceroute)" ]; then alias traceroute='grc traceroute'; fi
    if [ -x "$(command -v tune2fs)" ]; then alias tune2fs='grc tune2fs'; fi
    if [ -x "$(command -v ulimit)" ]; then alias ulimit='grc ulimit'; fi
    if [ -x "$(command -v uptime)" ]; then alias uptime='grc uptime'; fi
    if [ -x "$(command -v vmstat)" ]; then alias vmstat='grc vmstat'; fi
    if [ -x "$(command -v w)" ]; then alias w='grc w'; fi
    if [ -x "$(command -v wdiff)" ]; then alias wdiff='grc wdiff'; fi
    if [ -x "$(command -v whois)" ]; then alias whois='grc whois'; fi
fi
#!/usr/bin/env bash
# Determine platform
platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
	platform='macos'
fi

# Sourcing
if [[ $platform == 'macos' ]]; then
    # alias vim='/Applications/MacVim.app/Contents/bin/vim'
    alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
    math='/Applications/Mathematica.app/Contents/MacOS/WolframKernel'
    dash() {
        open "dash://$1"
    }

    e() {
        # open -a /Applications/Emacs.app "$@" --args --chdir "$PWD"
        open -a /Applications/Emacs.app "$@"
    }

	alias lldb='PATH=/usr/bin lldb' # Homebrew Python strikes again
	alias egrep='egrep --color=auto'
	alias ls='ls -GFh'
	alias ll='pwd && grc ls -lGFh'
	alias la='pwd && grc ls -alGFh'
	alias cli_update='cd $CUSTOM_PATH && git pull && cd && vim +PlugUpgrade +PlugUpdate +PlugClean! +qall && conda deactivate && cd && echo \Updating\ global\ packages\ && gem update && python -m pip install --upgrade pip && pip-review --local --auto && echo \Updating\ Conda\ && conda update -n base conda -y && conda clean -y --all && conda activate base && conda update anaconda -y && conda deactivate && echo \Updating\ Homebrew\ && brew upgrade && brew cask upgrade && brew cleanup && npm -g install npm && npm -g update && cd' # horrible
	alias ql='qlmanage -p 2>/dev/null'
	mand() {
		open "dash://$1"
	}
    function emacs_mac {
        t=()

  if [ ${#@} -ne 0 ]; then
    while IFS= read -r file; do
      [ ! -f "$file" ] && t+=("$file") && /usr/bin/touch "$file"
      file=$(echo $(cd $(dirname "$file") && pwd -P)/$(basename "$file"))
      $(/usr/bin/osascript <<-END
        if application "Emacs.app" is running then
          tell application id (id of application "Emacs.app") to open POSIX file "$file"
        else
          tell application ((path to applications folder as text) & "Emacs.app")
            activate
            open POSIX file "$file"
          end tell
        end if
END
      ) &  # Note: END on the previous line may be indented with tabs but not spaces
    done <<<"$(printf '%s\n' "$@")"
  fi

  if [ ! -z "$t" ]; then
    $(/bin/sleep 10; for file in "${t[@]}"; do
      [ ! -s "$file" ] && /bin/rm "$file";
    done) &
  fi
    }

else
	if [[ -s "/etc/grc.zsh" ]]; then
		/etc/grc.zsh
	fi
	alias ls='ls -Fh'
	export PATH="$PATH:$HOME/.local/bin"
	alias cli_update='cd $CUSTOM_PATH && git pull && cd && vim +PlugUpgrade +PlugUpdate +PlugClean! +qall && conda deactivate && cd' # horrible

fi

if [ -n "$PS1" ] && [ "$TERM" != "dumb" ]; then
    if [ -d "$HOME/.config/base16-shell" ] && [ -z $VIM ] && [ -z $EMACS ]; then
        BASE16_SHELL="$HOME/.config/base16-shell/"
#        eval "$("$BASE16_SHELL/profile_helper.sh") && base16_solarized-light"
    fi
    # get current branch in git repo
    function parse_git_branch() {
        BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        if [ ! "${BRANCH}" == "" ]; then
            STAT=$(parse_git_dirty)
            echo " [${BRANCH}${STAT}]"
        else
            echo ""
        fi
    }

    # get current status of git repo
    function parse_git_dirty() {
        status=$(git status 2>&1 | tee)
        dirty=$(
            echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
            echo "$?"
        )
        untracked=$(
            echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
            echo "$?"
        )
        ahead=$(
            echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
            echo "$?"
        )
        newfile=$(
            echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
            echo "$?"
        )
        renamed=$(
            echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
            echo "$?"
        )
        deleted=$(
            echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
            echo "$?"
        )
        bits=''
        if [ "${renamed}" == "0" ]; then
            bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
            bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
            bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
            bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
            bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
            bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
            echo " ${bits}"
        else
            echo ""
        fi
    }

    function nonzero_return() {
        RETVAL=$?
        [ $RETVAL -ne 0 ] && echo "$RETVAL "
    }

    # export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\][\[\e[32m\]\H\[\e[m\]:\[\e[34m\]\w\[\e[m\]\[\e[36m\]\`parse_git_branch\`\[\e[m\]] \[\e[35m\]\u\[\e[m\] \\$ "
    # export PS1="\e[0m<\[\e[33m\]\t\[\e[m\] \[\e[35m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]\[\e[36m\]\`parse_git_branch\`\[\e[m\]> "    
    reset="\001$(tput sgr0)\002"
    red="\001$(tput setaf 1)\002" 
    green="\001$(tput setaf 2)\002"
    yellow="\001$(tput setaf 3)\002" 
    blue="\001$(tput setaf 4)\002"
    magenta="\001$(tput setaf 5)\002" 
    cyan="\001$(tput setaf 6)\002" 
    
    PS1="$red\`nonzero_return\`$reset<$yellow\d \t$reset> "
    PS1+="<$magenta\u$reset@$green\h$reset:"
    PS1+="$blue\w$cyan\`parse_git_branch\`$reset>"
    PS1+="\n\$ "

    export PS1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

    unset reset red green yellow blue magenta
    # PROMPT_DIRTRIM=2
    # bind "TAB:menu-complete"
    bind "set completion-map-case on"
    bind "set mark-symlinked-directories on"
    bind "set menu-complete-display-prefix on"
    bind "set show-all-if-ambiguous on"
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind 'set match-hidden-files off'
    bind 'set show-all-if-ambiguous on'
    bind Space:magic-space
fi

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
