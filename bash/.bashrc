#
# ~/.bashrc
#

[[ -f ~/.bash_functions ]] && . ~/.bash_functions
[[ -f ~/.bash_functions_extra ]] && . ~/.bash_functions_extra
[[ -f ~/.bashrc_extra ]] && . ~/.bashrc_extra

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# She comes in colours everywhere...
alias ls='ls --color=always'
alias grep='grep --color=always'
alias pacman='pacman --color=always'
export LESS='--RAW-CONTROL-CHARS'

alias printer-settings='system-config-printer'

# Enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Enable extra git info in prompt if we are within a git repo.
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  source /usr/share/git/completion/git-prompt.sh
fi

if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

# pyenv
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
  pyenv global 3.12.9
  pyenv virtualenvwrapper_lazy
fi

# Overriding PATH after `pyenv init -`'s PATH overriding.
path_prepend "${HOME}/.local/bin"

# Python, virtualenv
alias pycov='pytest --cov=$(basename ${PWD}) --cov-report=html --cov-branch'
alias pytestv='pytest -svv --showlocals --log-cli-level=DEBUG --log-format="%(name)-25s %(lineno)4d %(levelname)-8s %(message)s"'
alias githubize='git rebase --ignore-date origin/master'
alias sed='sed --follow-symlinks'
alias gitsed='git-iter sed --follow-symlinks'
alias ssh='TERM=ansi ssh'

# History
shopt -s histappend # Append current shell's history to .bash_history instead of wiping out what was already in it.
shopt -s cmdhist    # Save multi-line commands as a single-line one.
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth # Prevent both duplicate and space-prefixed commands to make history.
HISTIGNORE='bg:fg:history'
