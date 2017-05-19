# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [ "$(hostname)" = meServer ]; then
	ZSH_THEME="hug1"
elif [ "$(hostname)" = devian ]; then
	ZSH_THEME="hug2"
elif [ "$(hostname)" = Gabriels-MBP ]; then
	ZSH_THEME="spaceship"
else
	ZSH_THEME="hug1"
	#ZSH_THEME="mortalscumbag"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

if command -v autojump >/dev/null 2>&1; then
	if [ -f /usr/share/autojump/autojump.sh ]; then
        . /usr/share/autojump/autojump.sh
    fi
fi

if [ "$(hostname)" = devwork ]; then
	echo "devwork"
	bindkey -v

	. /usr/share/autojump/autojump.sh
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
fi

alias cp="cp -i"                          # confirm before overwriting something
alias mv="mv -i"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
#alias lsa='ls -Ahsl' # already defined by oh-my-zsh
alias tmux="tmux -2"
alias grep="ack -A0 -B0"

if [ "$(hostname)" = archme ]; then
	alias vim='nvim'
fi

EDITOR=/usr/bin/nvim
export EDITOR

SVN_EDITOR=$EDITOR
export SVN_EDITOR


platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi

if [[ $platform == 'linux' ]]; then
	: 	# do nothing
elif [[ $platform == 'freebsd' ]]; then
	:	# do nothing
elif [[ $platform == 'darwin' ]]; then
	alias poweroff='sudo shutdown -s now'
	alias nvim='nvim -u ~/.nvimrc'
	alias vim='nvim'
	PATH=/usr/local/opt/subversion/bin:$PATH
fi

PATH=$PATH:~/nixconfig/sshscripts
PATH=$PATH:~/nixconfig/userscripts
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
export PATH

# create a directory and cd to it
mkcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}
