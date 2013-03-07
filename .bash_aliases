alias      a=alias
a          u=unalias
a          h=history
a          j=jobs
a          d='dirs -v'
a         po=popd
a         pu=pushd
a        rot='pushd +1'
a       home='ssh parker@192.168.0.101'
a       hafh='ssh parker@71.79.242.190'
a      procs='ps -elf | cut -c76- | sort | crk '/\d' | uniq -c | sort -n'
a        pid='ps axu  | grep \!* | grep -v grep'
a       pidw='ps axuww| grep \!* | grep -v grep'
a       slay='(set j=`ps -ax|grep \!*|head -1`;kill -9  $j[1]) >& /dev/null'
a        zap='(set j=`ps -ax|grep \!*|head -1`;kill -1  $j[1]) >& /dev/null'
a       term='(set j=`ps -ax|grep \!*|head -1`;kill -15 $j[1]) >& /dev/null'
a         sv='vi +"\!{:1}:" \!:2*'
a        lsd='ls -F'
a         ll='ls -l'
a         lr='ls -ltr'
a       dots='ls -d .??*'
a      lsdir='ls -l | grep drw'
a         cx='chmod +x'
a        mcd='mkdir \!:1; cd \!:1;'
a         ..='cd ..'
a          .=source
a          c=clear
a       orig='cp \!* \!*.orig'
a        day="date '+%a %h %d %Y'"
a        src='source ~/.tcshrc'
a        bye=exit
a     logout=exit
a         lo=exit
a         rp='set path=($path)'
a    prepath='set path=(\!* $path)'
a   postpath='set path=($path \!*)'
a    addpath='set path=($path \!*)'
a       here='set path=($path .)'
a    pwdpath='set path=($path `pwd`)'
a        ssh='ssh -XY'
a        ifc='ifconfig -a'
a        str='strings - \!* | less'
a        vrc='vi ~/.tcshrc'
a       vvrc='vi ~/.vimrc'
HISTSIZE=4096
HISTFILESIZE=4096
HISTCONTROL=erasedups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend

bind '"\ep": history-search-backward'
