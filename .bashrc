# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# { Define Colors Display
    BLACK="\[\033[0;30m\]"
    BLUE="\[\033[0;34m\]"
    GREEN="\[\033[0;32m\]"
    CYAN="\[\033[0;36m\]"
    RED="\[\033[0;31m\]"
    PURPLE="\[\033[0;35m\]"
    BROWN="\[\033[0;33m\]"
    DARK_GRAY="\[\033[1;30m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    LIGHT_BLUE="\[\033[1;34m\]"
    LIGHT_GREEN="\[\033[1;32m\]"
    LIGHT_CYAN="\[\033[1;36m\]"
    LIGHT_RED="\[\033[1;31m\]"
    LIGHT_PURPLE="\[\033[1;35m\]"
    YELLOW="\[\033[1;33m\]"
    WHITE="\[\033[1;37m\]"
    NO_COLOUR="\[\033[0m\]"
# }

# { Set prompt Color
    
    # If not running interactively, don't do anything
    [ -z "$PS1" ] && return

    # User specific aliases and functions
    PS1="$NO_COLOUR[$GREEN\$(date +%H%M)$NO_COLOUR][$BLUE\u$YELLOW@$PURPLE\h:$RED\W$CYAN]\$$NO_COLOUR"

    # set chroot prompt
    if [ -e /etc/debian_chroot ]; then
        export PS1="$NO_COLOUR[$GREEN\$(date +%H%M)$NO_COLOUR]:[$BLUE\u$YELLOW@$CYAN\$(cat /etc/debian_chroot)$YELLOW@$PURPLE\h:$RED\W$CYAN]\$$NO_COLOUR"
    fi
# }

# { TMUX resurect specific
    if [ $TERM == "screen" ]; then
        TMUX_BACKUP_DIR=~/.resurrect/tmux_history
        if [ ! -d "$TMUX_BACKUP_DIR" ]; then
            mkdir TMUX_BACKUP_DIR
        fi
        shopt -s histappend
        WINDOWS_INDEX=`tmux display-message -p "#I"`
        PANE_INDEX=`tmux display-message -p "#P"`
        SESSION_INDEX=`tmux display-message -p "#S"`
        HISTORY_FILE=$TMUX_BACKUP_DIR/$SESSION_INDEX:$WINDOWS_INDEX:$PANE_INDEX
        if [ ! -f "$HISTORY_FILE" ]; then
            echo "ls" > "$HISTORY_FILE"
        fi
        export PROMPT_COMMAND="WINDOWS_INDEX=\`tmux display-message -p \"#I\"\`; \
                                PANE_INDEX=\`tmux display-message -p \"#P\"\`; \
                                SESSION_INDEX=\`tmux display-message -p \"#S\"\`; \
                                HISTORY_FILE=\$TMUX_BACKUP_DIR/\$SESSION_INDEX:\$WINDOWS_INDEX:\$PANE_INDEX; \
                                history -a \$HISTORY_FILE; \
                                history -c; \
                                history -r \$HISTORY_FILE; \
                                $PROMPT_COMMAND"
    fi
# }

# { alias
    # { unix functions mappings
        alias xterm="xterm -rv +sb -sl 2000"
        alias g="egrep --color=always --exclude=\*.svn\* -r -n "
        alias hgrep='history | grep --color=always' 
        alias l="ls -lh"
        alias ll="ls -Alh"
        alias k="clear"
        alias p="pushd"
        alias pp="popd"
        function gg()
        {
            if [ -z $2 ]; then
                egrep --color=always --exclude=\*.svn\* -r -n $1 . | grep -v \.svn\/
            else
                egrep --color=always --exclude=\*.svn\* -r -n $1 . | grep --color=always $2 | grep -v \.svn\/
            fi
        }
        function gn()
        {
            egrep --color=always --exclude=\*.svn\* -r -n $1 . | grep -v $2 | grep -v \.svn\/
        }
        
        function scrpt() {
            echo "#!/bin/bash " >$1 ; echo " " >>$1 ; echo " " >>$1 && vim $1 && chmod +x $1
        }
    # }
    # { VIM
        alias vi="/usr/local/bin/vim -p"
        alias vim="/usr/local/bin/vim -p"
    # }
    
    # { Working dir shortcut
        export PATH=/sbin:$PATH:/usr/local/bin/
        export PATH=$PATH:~/bin/usr/local/bin
        export PATH=${PATH}:~/scripts
    # }
    
    # { SVN
        export SVN_EDITOR=vim
        alias sdiff='svn diff --diff-cmd meld'
        alias svnst='svn st | grep -v ^\?'
        alias svnstu='svn st -u | grep -v ^\?'
        alias svnignore='svn propset svn:ignore -F svnignore.txt .'
        source ~/scripts/svn-color.sh
    # }
    #calc
        alias calc='~/scripts/vc.pl'
    # { Virtual boxs
        alias opera-vbox="ssh -n vbox 'opera-next'"
    # }
    alias orpie="export TERM=xterm; ~/bin/usr/local/bin/orpie"
# }

# Specific { 

#}

# { Tests
    PROGS="vim ctags orpie svn"
    FULL_THRH=90
    
    # { Test Prog list installed
    for PROG in $PROGS; do
        command -v $PROG > /dev/null
        if [ $? -eq 1 ]; then
            echo "$PROG is not installed"
        fi
    done
    # }

    # { Test free space
    ret=`df -hlP | grep -v Filesystem |sed -e 's/  */ /g' | cut -d " " -f 1,5`
    number=`echo $ret | wc -w`
    for i in `seq $(($number/2))`; do
        percentage=`echo $ret | cut -d " " -f $(($i*2)) | cut -d "%" -f 1`
        if [ $percentage -gt $FULL_THRH ]; then
            echo -e "\033[1;31m" "Disk almost full on device `echo $ret | cut -d " " -f $(($i*2-1))`"
        fi
        done
    # }
    uptime

# }


