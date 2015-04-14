HISTSIZE=8192
HISTFILESIZE=8192
HISTCONTROL=erasedups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
bind '"\ep": history-search-backward'
alias      a=alias
a          u=unalias
a          h=history
a          j=jobs
a          d='dirs -v'
a         po=popd
a         pu=pushd
a        rot='pushd +1'
# a       home='ssh parker@192.168.0.101'
# a       hafh='ssh parker@71.79.242.190'
a        lsd='ls -F'
a         ll='ls -l'
a         lr='ls -ltr'
a       dots='ls -d .??*'
a      lsdir='ls -l | grep drw'
a         cx='chmod +x'
a         ..='cd ..'
a          .=source
a          c=clear
a        day="date '+%a %h %d %Y'"
a        src='source ~/.bash_profile'
a        bye=exit
a     logout=exit
a         lo=exit
a        ssh='ssh -XY'
a        ifc='ifconfig -a'
a        str='strings - \!* | less'
a         vi=vim
a        vrc='vim ~/.bash_profile'
a        arc='vim ~/.bash_aliases'
a       vvrc='vim ~/.vimrc'
a         rp='hash -r'
function mine {
        export PERL5LIB="/home/parks17/etc/perllib:${PERL5LIB}"
        export PATH="/home/parks17/bin:${PATH}"
        # export PATH=`/home/parks17/bin/cleanpath`
        # export HISTSIZE=8192
        # cd /investments/bee_hive/bee_config_tidied
}
function here {
        export PATH="${PATH}:."
}
function addpath {
        export PATH="${PATH}:$1"
}
function postpath {
        export PATH="${PATH}:$1"
}
function prepath {
        export PATH="$1:${PATH}"
}
function pwdpath {
        export PATH="`pwd`:${PATH}"
}
function mcd {
        mkdir $1
        cd $1
}
function sv {
        vi +"$1:" $2*
}
function orig {
        cp $1 $1.orig
}
a      procs='ps -eo "pid,ppid,tty,user,cputime,cmd"'
a       hogs='ps -eo "pid,ppid,tty,user,cputime,cmd" | egrep "[        ]0[^0]:|[       ]00:[^0]" | cut -c31- | sort'
a        pid='ps axu  | grep \!* | grep -v grep'
a       pidw='ps axuww| grep \!* | grep -v grep'
a       slay='(set j=`ps -ax|grep \!*|head -1`;kill -9  $j[1]) >& /dev/null'
a        zap='(set j=`ps -ax|grep \!*|head -1`;kill -1  $j[1]) >& /dev/null'
a       term='(set j=`ps -ax|grep \!*|head -1`;kill -15 $j[1]) >& /dev/null'
