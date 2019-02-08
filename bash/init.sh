#!/usr/bin/env bash
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # exec tmux -CC
# fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

source "$CUSTOM_PATH/bash/settings.sh"
source "$CUSTOM_PATH/bash/profile.sh"
source "$CUSTOM_PATH/bash/alias.sh"
source "$CUSTOM_PATH/bash/grc.sh"
source "$CUSTOM_PATH/bash/prompt.sh"
source "$CUSTOM_PATH/bash/platform.sh"
