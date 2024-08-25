#! /usr/bin/env bash
cd deployed/home

GLOBIGNORE=".:.."
for i in .*; do 
    mv "$HOME/$i"{,.bak};
    ln -sf "$(pwd)/$i" "$HOME/$i";
 done

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo Old configuration files have not been overwritten
echo Mathematica, iTerm, Emacs, IDEA configs etc cannot be installed automatically
