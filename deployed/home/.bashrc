export CUSTOM_PATH=~/.config/orpheus
# Do not edit these settings - put desired changes in $override_path
iterm_integration=true
multi_line_prompt=true
show_return_code=true
emacs_override=true
override_path="$HOME/.bashrc_local"
if [[ -f $override_path ]]; then
    source $override_path
fi

if [ -d "/usr/local/instantclient_12_2" ]; then
    export ORACLE_HOME=/usr/local/instantclient_12_2
    export TNS_ADMIN=$ORACLE_HOME/network/admin
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
    export CLASSPATH=$CLASSPATH:$ORACLE_HOME
    export PATH="$ORACLE_HOME:$PATH"
fi
if [ -d "$HOME/.roswell" ]; then
    export PATH="$HOME/.roswell/bin:$PATH"
fi
if [ -d "/Applications/calibre.app/" ]; then
    export PATH="$HOME/Applications/calibre.app/Contents/console.app/Contents/MacOS:$PATH"
fi
if [ -d "/Applications/Mathematica.app/" ]; then
    export PATH="/Applications/Mathematica.app/Contents/MacOS:$PATH"
fi
if [ -d "/Applications/JuliaPro-0.6.2.2.app/" ]; then
    export PATH="/Applications/JuliaPro-0.6.2.2.app/Contents/MacOS:$PATH"
fi

if [ -d "$HOME/anaconda3/" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

if [ -d "/usr/local/share/android-ndk" ]; then
    export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
fi

if [ -d "/usr/local/nvm" ]; then
export NVM_DIR="/usr/local/nvm";
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh";
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm";
fi

if [ -e "command -v go" ]; then
    export GOPATH="~/go"
fi

if [ -d "/usr/local/anaconda3" ]; then
    # export PATH="/usr/local/anaconda3/bin:$PATH"
    source "/usr/local/anaconda3/etc/profile.d/conda.sh"
fi
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
set -o vi
if $emacs_override; then
    if [ -e "/usr/local/bin/bbedit" ]; then
        export VISUAL='bbedit'
    else
       export VISUAL='emacs -nw'
    fi
   set -o emacs
else
        export VISUAL='vim'
    set -o vi
fi
export EDITOR="$VISUAL"
alias y="open -a Yoink.app"
alias bb="open -a BBEdit.app"
if [ -x "$(command -v brew)" ]; then
    if type brew &>/dev/null; then
      HOMEBREW_PREFIX="$(brew --prefix)"
      if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
      else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
          [[ -r "$COMPLETION" ]] && source "$COMPLETION"
        done
      fi
    fi
    export HOMEBREW_NO_INSECURE_REDIRECT=1
#     export HOMEBREW_CASK_OPTS=--require-sha
fi
export LC_CTYPE=en_US.UTF-8

export PATH=$PATH:/usr/local/Cellar/python/3.7.2/Frameworks/Python.framework/Versions/3.7/bin

# if [ -x "$(command -v perl)" ]; then
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
# fi

if [ -x "$(command -v ruby)" ]; then
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
fi

if [ -x "$(command -v mono)" ]; then
      export MONO_GAC_PREFIX="/usr/local"
fi

export LC_ALL=en_US.UTF-8


[[ -f /usr/local/etc/bash_completion ]] && . /usr/local/etc/bash_completion

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
# complete -o nospace -F _cd cd
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
function idea_i() {
    for i in "$@"; do
        idea "$(pwd)/$i" >/dev/null 2>&1
    done
}

# alias mvim='open -a /Applications/MacVim.app'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
#alias clang++='clang++ -std=c++11 -Wall'
#alias clang='clang -std=c11 -Wall'
alias df='df -h'
alias du='du -h'
alias fpc='fpc -Mtp -vewl'
alias fzfs='mdfind -onlyin ~ "*" | fzf'
alias gcc='gcc -std=c11 -Wall'
alias g++='g++ -std=c++11 -Wall'
alias grep='grep --color=auto'
alias ls='ls -GFh'
alias motd='cat /etc/motd'
#alias nasm-2.13='nasm -Wall'
alias posix_sh='sh --posix +B && unalias -a && alias vi = vi -u NONE -U NONE -N
 -i NONE -c "set compatible" && clear && motd'
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


if [ -n "$PS1" ] && [ "$TERM" != "dumb" ]; then
    shell_no_background=true
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

    if [[ ${show_return_code} = true ]]; then
        PS1="$red\`nonzero_return\`$reset";
    fi
    PS1+="[$yellow\d \t$reset] "
    PS1+="[$magenta\u$reset@$green\h$reset:"
    PS1+="$blue\w$cyan\`parse_git_branch\`$reset]"
    if [[ ${multi_line_prompt} = true ]]; then
      PS1+="\n";
    fi
    PS1+="\$ "
    # export PS1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    export PROMPT_COMMAND='echo -ne "\033]0;$USER@$(hostname -s):$(dirs +0)\007"'

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

if [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
    BASE16_SHELL="$HOME/.config/base16-shell/"
    [[ -n "$PS1" ]] && \
        [[ -s "$BASE16_SHELL/profile_helper.sh" ]] && \
            eval "$("$BASE16_SHELL/profile_helper.sh")"

    if [[ -s "$HOME/.config/base16-fzf/bash/base16-solarized-light.config" ]];
then
        source "$HOME/.config/base16-fzf/bash/base16-solarized-light.config";
fi
fi

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
    math='/Applications/Mathematica.app/Contents/MacOS/WolframKernel'
    alias ql='qlmanage -p 2>/dev/null'
    alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
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

    _nvm_update() {
        prev_ver=$(nvm current)
        nvm install node
        nvm reinstall-packages $prev_ver
        nvm uninstall $prev_ver
        nvm cache clear
        unset reset prev_ver
    }

    _cust_update() {
        cd $CUSTOM_PATH
        git pull
    }

    _conda_update() {
        conda update -n base conda -y
        conda clean -y --all
        conda activate base
        conda update anaconda -y
    }

    _pip_update() {
        python -m pip install --upgrade pip
        pip-review --local --interactive --all
    }
    _brew_update() {
         brew upgrade
         brew cleanup
    }

    _cli_update() {
        echo "\e[34mUpdating Ruby\e[39m"
        gem update

        echo "\e[34mUpdating base16\e[39m"
        cd $XDG_CONFIG_HOME/base16-shell
        git pull
        cd ..
        cd base16-fzf
        git pull
        cd

        echo "\e[34mUpdating Pip\e[39m"
        _pip_update

        echo "\e[34mUpdating Conda base env\e[39m"
        _conda_update

        echo "\e[34mUpdating NVM and Node\e[39m"
        _nvm_update

        echo "\e[34mUpdating Homebrew\e[39m"
        _brew_update

        echo "\e[34mUpdating TeXLive\e[39m"
        tlmgr update --self
        tlmgr update --all

        echo "\e[34mUpdating Mac App Store apps\e[39m"
        mas upgrade
    }


#     alias cli_update=' && conda deactivate && cd && echo \Updating\ global\ packages\ && mas upgrade && gem update && python -m pip install --upgrade pip && echo \Updating\ Conda\ && conda update -n base conda -y && conda clean -y --all && conda activate base && conda update anaconda -y && conda deactivate && echo \Updating\ Homebrew\ && brew upgrade && brew cask upgrade && brew cleanup && npm -g install npm && npm -g update && cd' # horrible
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

_enable_fingerprint_auth() {
    if ! grep pam_tid.so /etc/pam.d/sudo; then
        sudo gsed -i '1i auth sufficient pam_tid.so' /etc/pam.d/sudo
    fi
}

if [[ ${iterm_integration} = true ]];  then
    if [[ ! -f ~/.iterm2_shell_integration.bash ]]; then
        curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
    fi
    source ~/.iterm2_shell_integration.bash
fi
# conda activate base

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
