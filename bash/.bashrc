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
alias yay='yay --color=always'
export LESS='--RAW-CONTROL-CHARS'

alias printer-settings='system-config-printer'

# Declare nice color names
# ( source https://wiki.archlinux.org/index.php/Color_Bash_Prompt )
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
bakgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White
txtrst='\033[0m'    # Text Reset

# Enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

source /usr/share/git/completion/git-prompt.sh

# TODO Find a nicer way of writing the code below
return_code="\[$bldwht\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[$bldgrn\]\342\234\223\"; else echo \"\[$bldred\]\342\234\227\"; fi) "
before_git_ps1="\[$bldylw\][\[$bldgrn\]\u\[$bldylw\]@\h\[$txtwht\]"
after_git_ps1=" \[$bldred\]\W\[$bldylw\]]\[$txtrst\] $ "

# /!\ Do not forget \[...\] around colors to tell bash color content is 0 characters long
PS1=$return_code$before_git_ps1'$(__git_ps1)'$after_git_ps1

# Python, virtualenv
alias pycov='pytest --cov=$(basename ${PWD}) --cov-report=html --cov-branch'
alias pytestv='pytest -svv --showlocals --log-cli-level=DEBUG --log-format="%(name)-25s %(lineno)4d %(levelname)-8s %(message)s"'
alias githubize='git rebase --ignore-date origin/master'
alias sed='sed --follow-symlinks'
alias gitsed='git-iter sed --follow-symlinks'
alias ssh='TERM=ansi ssh'

# History
shopt -s histappend;  # Append current shell's history to .bash_history instead of wiping out what was already in it.
shopt -s cmdhist;  # Save multi-line commands as a single-line one.
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth;  # Prevent both duplicate and space-prefixed commands to make history.
HISTIGNORE='bg:fg:history'
