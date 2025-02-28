#
# ~/.bash_profile
#

export BROWSER="firefox"
export CDPATH=".:${HOME}/Repo:${HOME}/Projects"

[[ -f ~/.bash_profile_extra ]] && . ~/.bash_profile_extra
[[ -f ~/.bashrc ]] && . ~/.bashrc

# fzf
export FZF_DEFAULT_COMMAND="fd --type f"

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  # Wayland
  if command -v uwsm &>/dev/null; then
    if uwsm check may-start; then
      exec uwsm start hyprland.desktop
    fi
  fi
  # X.Org
  if command -v startx &>/dev/null; then
    exec startx
  fi
fi
