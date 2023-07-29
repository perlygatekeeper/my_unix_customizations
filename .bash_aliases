HISTSIZE=8192
HISTFILESIZE=8192
HISTCONTROL=erasedups:ignorespace
# append to the history file, don't overwrite it
# shopt -s histappend
# bind '"\ep": history-search-backward'
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
#function mine {
        # export PERL5LIB="/home/parks17/etc/perllib:${PERL5LIB}"
        # export PATH="/home/parks17/bin:${PATH}"
        # export PATH=`/home/parks17/bin/cleanpath`
        # export HISTSIZE=8192
        # cd /investments/bee_hive/bee_config_tidied
#}
function here {
        PATH="${PATH}:."
}
function addpath {
        PATH="${PATH}:$1"
}
function postpath {
        PATH="${PATH}:$1"
}
function prepath {
        PATH="$1:${PATH}"
}
function pwdpath {
        PATH="`pwd`:${PATH}"
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

a d2h="perl -e 'printf qq|%X\n|, int( shift )'"
a d2o="perl -e 'printf qq|%o\n|, int( shift )'"
a d2b="perl -e 'printf qq|%b\n|, int( shift )'"

a h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
a h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
a h2b="perl -e 'printf qq|%b\n|, hex( shift )'"

a o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
a o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
a o2b="perl -e 'printf qq|%b\n|, oct( shift )'"
# export TERM=xtermc
#
#        beginning-of-history (M-<)
#                     Move to the first line in the history.
#       end-of-history (M->)
#              Move to the end of the input history, i.e., the line currently being entered.
#       reverse-search-history (C-r)
#              Search backward starting at the current line and moving `up' through the history as necessary.  This is an incremental search.
#       forward-search-history (C-s)
#              Search forward starting at the current line and moving `down' through the history as necessary.  This is an incremental search.
#       non-incremental-reverse-search-history (M-p)
#              Search backward through the history starting at the current line using a non-incremental search for a string supplied by the user.
#       non-incremental-forward-search-history (M-n)
#              Search forward through the history using a non-incremental search for a string supplied by the user.
#       history-search-forward
#              Search forward through the history for the string of characters between the start of the current line and the point.  This is a non-incremental search.
#       history-search-backward
#              Search backward through the history for the string of characters between the start of the current line and the point.  This is a non-incremental search.
bind '"\ep": history-search-backward'
bind '"\en": history-search-forward'

a ginfo='echo "Branches:"; git branch -v; echo "\nRemotes:"; git remote -v; echo "\nStatus:"; git status'
a   gic='git commit'
a gicam='git commit -a -m '
a  gich='git checkout'
a   gib='git branch'
a  gibv='git branch -v'
a  gibr='git branch -r'
a   gir='git remote'
a  girv='git remote -v'
a   gis='git status'
a  gidi='git diff'
a gpush='git push origin'
a gpull='git pull origin'
a  gits='a | grep git'
# get a new branch from github for the first time.
# > git checkout master
# > git pull
# > git checkout -b company-megabrowse-navigation --track origin/company-megabrowse-navigation
