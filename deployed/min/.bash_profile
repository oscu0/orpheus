if [ -f ~/.profile ]; then
    source ~/.profile
fi

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='darwin'
fi

# if [ -f ~/.bashrc ] && [[ "$platform" == 'darwin' ]]; then
#     source ~/.bashrc
# fi
# 
# if [ "$TERM" = "screen" ] || [ -n "$TMUX" ]; then
#     source ~/.bashrc
# fi

unset $unamestr

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

source ~/.bashrc 
