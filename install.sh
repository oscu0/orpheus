#! /usr/bin/env bash
cd deployed/home
GLOBIGNORE=".:.."
for i in .*; do 
    mv ~/$i{,.bak};
    ln -sf $(pwd)/$i ~/$i;
 done

echo Old configuration files have not been overwritten
echo Mathematica, iTerm, Emacs, IDEA configs etc cannot be installed automatically
