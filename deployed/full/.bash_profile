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
# export PATH="$HOME/.roswell/bin:/Applications/calibre.app/Contents/console.app/Contents/MacOS:/Applications/Mathematica.app/Contents/MacOS/:/Applications/JuliaPro-0.6.2.2.app/Contents/Resources/julia/Contents/Resources/julia/bin/:$ORACLE_HOME:/usr/local/sbin:/usr/local/bin:$PATH"

if [ -d "$HOME/anaconda3/" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

if [ -d "/usr/local/anaconda3" ]; then
    # export PATH="/usr/local/anaconda3/bin:$PATH"
    source "/usr/local/anaconda3/etc/profile.d/conda.sh"
fi
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
if [ -e "command -v atom" ]; then
    export VISUAL='/usr/local/bin/atom'
else
    export VISUAL='vim'
fi
export EDITOR="$VISUAL"
if [ -e "command -v brew" ]; then
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS=--require-sha
fi
export LC_CTYPE=en_US.UTF-8

export PATH=$PATH:/usr/local/Cellar/python/3.7.2/Frameworks/Python.framework/Versions/3.7/bin

if [ -e "command -v perl" ]; then
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
fi

if [ -e "command -v ruby" ]; then
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
fi

export LC_ALL=en_US.UTF-8

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='darwin'
    source ~/.bashrc
fi

unset $unamestr

test -e "${HOME}/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"

