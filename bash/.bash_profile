#
# ~/.bash_profile
#

export BROWSER="firefox"
export CDPATH=".:${HOME}/Repo:${HOME}/Projects"

[[ -f ~/.bash_profile_extra ]] && . ~/.bash_profile_extra
[[ -f ~/.bashrc ]] && . ~/.bashrc

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

# fzf
export FZF_DEFAULT_COMMAND="fd --type f"

# pyenv
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
    pyenv global 3.12.7
    pyenv virtualenvwrapper_lazy
fi

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
