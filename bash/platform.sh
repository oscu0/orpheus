#!/usr/bin/env bash
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
	alias lldb='PATH=/usr/bin lldb' # Homebrew Python strikes again
	alias egrep='egrep --color=auto'
	alias ls='ls -GFh'
	alias ll='pwd && grc ls -lGFh'
	alias la='pwd && grc ls -alGFh'
	alias cli_update='cd $CUSTOM_PATH && git pull && cd && vim +PlugUpgrade +PlugUpdate +PlugClean! +qall && conda deactivate && cd && echo \Updating\ global\ packages\ && mas upgrade && gem update && python -m pip install --upgrade pip && pip-review --local --auto && echo \Updating\ Conda\ && conda update -n base conda -y && conda clean -y --all && conda activate base && conda update anaconda -y && conda deactivate && echo \Updating\ Homebrew\ && brew upgrade && brew cask upgrade && brew cleanup && npm -g install npm && npm -g update && cd' # horrible
	alias ql='qlmanage -p 2>/dev/null'
	mand() {
		open "dash://$1"
	}
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
