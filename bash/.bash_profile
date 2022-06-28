#
# ~/.bash_profile
#

export BROWSER="firefox"
export CDPATH=".:${HOME}/Repo:${HOME}/Projects"

[[ -f ~/.bash_profile_extra ]] && . ~/.bash_profile_extra
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi
