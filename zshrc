# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="candy"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
#	thefuck
	systemd
    docker
)


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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias pacaur="pacaur --color=auto"
alias tmux="tmux attach || tmux"
alias nn="ninja"
alias ch="cheat"

alias gsp="git stash push -u -m 'pull temp' && git pull --rebase && git stash pop && echo 'FIN'; "

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

eval `dircolors ~/dotfiles/dircolors.256dark`

source $ZSH/oh-my-zsh.sh
export MC_SKIN=~/.mc/lib/solarized.ini
export LC_ALL=en_US.UTF-8
export DISPLAY=:0.0
export GPG_TTY=$(tty)
#export GNUPGHOME=/mnt/i/gnupg
export EDITOR=vim
PATH=$PATH:~/go/bin

init_wsl() {
    SSH_AUTH_KEEAGENT_SOCK=/mnt/c/Users/Rubikoid/ag_msys
    SSH_AUTH_TMPDIR="/home/rubikoid/.ssh" # `mktemp --tmpdir --directory keeagent-ssh.XXXXXXXXXX`
    export DISPLAY=127.0.0.1:0.0
}

init_wsl_2() {
    SSH_AUTH_TMPDIR="/home/rubikoid/.ssh" # `mktemp --tmpdir --directory keeagent-ssh.XXXXXXXXXX`
    export REAL_WSL_ADDR=`netsh.exe interface ip show ipaddresses "vEthernet (WSL)" | head -n 2 - | tail -n 1 | awk '{ print $2; }'`
    export INTR_WSL_ADDR=`ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'` 
    # netsh.exe interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=172.18.28.x
    export DISPLAY=$REAL_WSL_ADDR:0.0
    
    alias npp="notepad++.exe"
    alias subdrop="sudo subsystemctl shell -s -u 1000"
    alias exp="explorer.exe"
    alias gcli='powershell.exe -command "Get-Clipboard"'
    alias scli="clip.exe"
    alias wcode="cmd.exe /c 'code .'"
}

redo_ssh() {
    SSH_AUTH_KEEAGENT_PORT=`sed -r 's/!<socket >([0-9]*\b).*/\1/' ${SSH_AUTH_KEEAGENT_SOCK}`
    export SSH_AUTH_SOCK="${SSH_AUTH_TMPDIR}/agent"
    if [ ! -e "$SSH_AUTH_SOCK" ]; then
        echo "ssh socket ($SSH_AUTH_SOCK) not found"
        socat UNIX-LISTEN:${SSH_AUTH_SOCK},mode=0600,fork,shut-down TCP:127.0.0.1:${SSH_AUTH_KEEAGENT_PORT},connect-timeout=2 >/dev/null 2>&1 &
    fi
    echo "SSH_AUTH_SOCK: ${SSH_AUTH_SOCK}"
}

redo_ssh_wsl2() {
    export SSH_AUTH_SOCK="${SSH_AUTH_TMPDIR}/agent"
    if [ ! -e "$SSH_AUTH_SOCK" ]; then
        echo "ssh socket ($SSH_AUTH_SOCK) not found"
        socat UNIX-LISTEN:${SSH_AUTH_SOCK},mode=0600,fork,shut-down EXEC:"/mnt/c/Code/tmp/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork >/dev/null 2>&1 &
    fi
    echo "SSH_AUTH_SOCK: ${SSH_AUTH_SOCK}"
}


get_path_from_old_shell() {
    # chpwd() {
    #     export SHORT_PWD=
    # }

    SHORT_PWD_DUMP_PATH="/tmp/short_pwd_dump"
    
    TRAPUSR1() {
        # echo "$SHORT_PWD" > /tmp/short_pwd_dump
        print -rD $PWD > $SHORT_PWD_DUMP_PATH
    }

    # kill -USR1 $(ps u | grep $(echo "$SOURCE_PANE_TTY" | awk -F/ '{print $3 "/" $4;}') | awk '/\-zsh$/{print $2; }')
    if [[ -n "$SOURCE_PANE_PID" ]]; then
        kill -USR1 "$SOURCE_PANE_PID";sleep 0.1;
        KILL_STATUS=$?;
        if [[ -e "$SHORT_PWD_DUMP_PATH" ]]; then 
            echo "Source pid=$SOURCE_PANE_PID; path=$(cat "$SHORT_PWD_DUMP_PATH")"
            eval cd $(cat "$SHORT_PWD_DUMP_PATH") && \
            rm "$SHORT_PWD_DUMP_PATH"
        else
            echo "Source pid=$SOURCE_PANE_PID; no file at '$SHORT_PWD_DUMP_PATH' "
        fi;
     fi;
}

completion_fix() {
    autoload -Uz compinit
    zstyle ':completion:*' menu select
    fpath+=~/.zfunc
    compinit
}

source ~/.zshrc_comp_dep

