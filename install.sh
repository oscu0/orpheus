#!/usr/bin/env bash
# This assumes you have reasonable recent vim, zsh, git, curl
# Make sure to edit completer list in vim/plugins.vim in YouCompleteMe settins
# Custom path is set to current directory - move .custom before installing
export CUSTOM_PATH=~/.config/orpheus
# CUSTOM_PATH=${CUSTOM_PATH%/}

# Smart autocomplete (incomplete list): python, python-dev, build-essentials, node, go, clang

declare -a full_dependencies=(
    bash
    vim
    tmux
    ipython
)

declare -a ycm_dependencies=(
    python
    node
    npm
    clang
    go
    rustc
    tsserver
    xbuild
    cargo
)

# Deploy symlinked files
for i in $(ls deployed/min);
do
    ln -s "$(pwd)/deployed/$i" "~/$i"
done

if [$1 == "full"]; then
    for i in $(ls deployed/full);
    do
        ln -s "$(pwd)/deployed/$i" "~/$i"
    done

    for i in full_dependencies; do
        if ![ command -v $i ]; then
            echo "$i missing"
        fi
    done

    # base16
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

    # Vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall

    for i in ycm_dependencies; do
        if ![ command -v $i ]; then
            echo "$i not found, vim code intelligence will not compile"
        fi
    done

fi


ln -s "$(pwd)/deployed/karabiner.json" "~/.config/karabiner/karabiner.json"

