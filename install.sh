#!/usr/bin/env zsh
# This assumes you have reasonable recent vim, zsh, git, curl
# Make sure to edit completer list in vim/plugins.vim in YouCompleteMe settins
# Custom path is set to current directory - move .custom before installing
export CUSTOM_PATH=~/.config/custom
# CUSTOM_PATH=${CUSTOM_PATH%/}

# Package list:
# Smart autocomplete (incomplete list): python, python-dev, build-essentials, node, go, clang


# Deploy symlinked files
for i in $(ls deployed/home);
do
    ln -s "$(pwd)/deployed/$i" "~/$i"
done

ln -s "$(pwd)/deployed/karabiner.json" "~/.config/karabiner/karabiner.json"

# base16
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall
