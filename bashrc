# set vim keybindings in command line
set -o vi

# set colours such that vim colourscheme works properly
export TERM=screen-256color

# source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# source git bash completion
[ -f /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git

# user specific aliases and functions
alias ll="ls -l"
alias la="ls -la"
alias python="python3"
alias rm="rm -iv"

# command prompt
parse_git_branch () {
	# function to get git branch from current directory
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# colors are defined in "\e[x;ym <colored_content> \e[m" where x;y is the color pair (x=0/1(dark/light), y=color)
# export PS1="\u@\h \e[0;36m\w\e[m\e[0;35m\$(parse_git_branch)\e[m $ "
LIGHT_BLUE="36"
MAGENTA="35"
# prompt below will result in "<username>@<hostname> <current_directory> (<git_branch>) $"
export PS1="\[\033[0;${LIGHT_BLUE}m\]\u@\h \w\[\033[0;${MAGENTA}m\]\$(parse_git_branch) \n\[\033[0;m\]$ "

set_bash_completion_case_insensitive () {
    # function to make bash tab-completion case-insensitive
    # on a new system, call this once
    # If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
    # so it won't get overriden
    if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi

    # Add shell-option to ~/.inputrc to enable case-insensitive tab completion
    echo 'set completion-ignore-case On' >> ~/.inputrc
}

# source system-specific stuff if bash-extra exists
[ -f ~/.bashrc_extra ] && . ~/.bashrc_extra

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/software/anaconda3/5.2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/software/anaconda3/5.2/etc/profile.d/conda.sh" ]; then
        . "/software/anaconda3/5.2/etc/profile.d/conda.sh"
    else
        export PATH="/software/anaconda3/5.2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

