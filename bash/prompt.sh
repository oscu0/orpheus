#!/usr/bin/env bash
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
    
    PS1="$red\`nonzero_return\`$yellow\t$reset "
    PS1+="[$magenta\u$reset@$green\h$reset:"
    PS1+="$blue\w$cyan\`parse_git_branch\`$reset] $ "
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

if [ $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]; then
    BASE16_SHELL="$HOME/.config/base16-shell/"
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
            eval "$("$BASE16_SHELL/profile_helper.sh")"

    source "$HOME/.config/base16-fzf/bash/base16-solarized-light.config"
fi
