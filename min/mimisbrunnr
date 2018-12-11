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
# if [ -d "$HOME/anaconda3/" ]; then
    # export PATH="$HOME/anaconda3/bin:$PATH"
# fi
 if [ -d "/usr/local/anaconda3" ]; then
    # export PATH="/usr/local/anaconda3/bin:$PATH"
    source /usr/local/anaconda3/etc/profile.d/conda.sh
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
export CUSTOM_PATH="$HOME/.config/custom"
if [ -e "command -v brew" ]; then
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS=--require-sha
fi
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
