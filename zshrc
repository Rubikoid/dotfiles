if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ZSH=/usr/share/oh-my-zsh/
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ZSH=/usr/local/share/oh-my-zsh/
fi

ZSH_THEME="candy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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

plugins=(
	git
	systemd
    docker
)


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

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval `dircolors ~/dotfiles/dircolors.256dark`
fi

alias tmux="tmux attach || tmux"
alias nn="ninja"
alias ch="cheat"

export MC_SKIN=~/.mc/lib/solarized.ini
export LC_ALL=en_US.UTF-8
export DISPLAY=:0.0
export GPG_TTY=$(tty)
export EDITOR=vim

PATH=$PATH:~/go/bin

post_init() {

}

init_wsl() {
    # for very old WSL1 systems...
    SSH_AUTH_KEEAGENT_SOCK=/mnt/c/Users/Rubikoid/ag_msys
    SSH_AUTH_TMPDIR="/home/rubikoid/.ssh" # `mktemp --tmpdir --directory keeagent-ssh.XXXXXXXXXX`
    export DISPLAY=127.0.0.1:0.0
}

init_wsl_2() {
    # modern WSL2 system
    SSH_AUTH_TMPDIR="/home/rubikoid/.ssh" # `mktemp --tmpdir --directory keeagent-ssh.XXXXXXXXXX` 
    export REAL_WSL_ADDR=`netsh.exe interface ip show ipaddresses "vEthernet (WSL)" | head -n 2 - | tail -n 1 | awk '{ print $2; }'`
    export INTR_WSL_ADDR=`ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'` 
    # netsh.exe interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=172.18.28.x
    export DISPLAY=$REAL_WSL_ADDR:0.0
    
    post_init_subsys() {
        if subsystemctl is-inside; then
            # PROMPT="$PROMPT""[sub]" 
            PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} [sub] $(git_prompt_info)\
%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} ' 
        fi
    }

    alias npp="notepad++.exe"
    alias subdrop="sudo subsystemctl shell -s -u 1000"
    alias exp="explorer.exe"
    alias gcli='powershell.exe -command "Get-Clipboard"'
    alias scli="clip.exe"
    alias wcode="cmd.exe /c 'code .'"
}

init_mac() {
    # for mac os
    plugins+=(
        macos
        golang
        #zsh-syntax-highlighting
    )

    test -e /Users/rubikoid/.iterm2/shell_integration.zsh && source /Users/rubikoid/.iterm2/shell_integration.zsh || true 
    
    alias diec='/Applications/die.app/Contents/MacOS/diec'
    alias scli='pbcopy'
    alias gcli='pbpaste'
    alias far='open -a /opt/homebrew/bin/far2l'
    # source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

redo_ssh() {
    # setup SSH
    SSH_AUTH_KEEAGENT_PORT=`sed -r 's/!<socket >([0-9]*\b).*/\1/' ${SSH_AUTH_KEEAGENT_SOCK}`
    export SSH_AUTH_SOCK="${SSH_AUTH_TMPDIR}/agent"
    if [ ! -e "$SSH_AUTH_SOCK" ]; then
        echo "ssh socket ($SSH_AUTH_SOCK) not found"
        socat UNIX-LISTEN:${SSH_AUTH_SOCK},mode=0600,fork,shut-down TCP:127.0.0.1:${SSH_AUTH_KEEAGENT_PORT},connect-timeout=2 >/dev/null 2>&1 &
    fi
    echo "SSH_AUTH_SOCK: ${SSH_AUTH_SOCK}"
}

redo_ssh_wsl2() {
    # also setup ssh, but for wsl2
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

    load_old_path() {
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
}

init_fzf() {
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    # env | grep FZF
    source ~/dotfiles/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
}

completion_fix() {
    autoload -Uz compinit
    zstyle ':completion:*' menu select
    fpath+=~/.zfunc
    compinit
}

source ~/.zshrc_comp_dep
source $ZSH/oh-my-zsh.sh
post_init

# drop profiling
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi
