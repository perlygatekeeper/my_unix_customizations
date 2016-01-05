
==> kill.cmd <==
@echo ----- 
@echo use taskkill /? to learn about windows taskkill command 
@echo or tskill /? 
@echo ----- 

perl -ne 'chomp; s/==//g; s/ <//;  $c=<>; chomp $c; printf "\@echo \%s \%s\r\n", $c, $_;'

@echo @findstr %1 %2 %3 %4 %5 %6 %7 %8 %9 > ack2.cmd
@echo @cls > c.cmd
@echo @cls > clear.cmd
@echo @type %1 %2 %3 %4 %5 %6 %7 %8 %9 > cat.cmd
@echo @chdir %1 > cd.cmd
@echo @copy %1 %2 %3 %4 %5 %6 %7 %8 %9 > cp.cmd
@echo @date /T > date.cmd
@echo @comp > diff.cmd
@echo @set > env.cmd
@echo @where /R %1 /F %2 %3 %4 %5 %6 %7 %8 %9 > find.cmd
@echo @find > grep.cmd
@echo @dir /n /q %1 %2 %3 %4 %5 %6 %7 %8 %9 > ll.cmd
@echo @mklink %1 %2 > ln-s.cmd
@echo @mklink /H %1 %2 > ln.cmd
@echo @dir /n /O:D /T:W > lr.cmd
@echo @dir /w %1 %2 %3 %4 %5 %6 %7 %8 %9 > ls.cmd
@echo @dir /w > lsd.cmd
@echo @mkdir %1 > mkdir.cmd
@echo @type %1 %2 %3 %4 %5 %6 %7 %8 %9 > more.cmd
@echo @rename %1 %2 > mv.cmd
@echo @tasklist /v > pidw.cmd
@echo @popd > po.cmd
@echo @tasklist > ps.cmd
@echo @pushd %1 > pu.cmd
@echo @chdir > pwd.cmd
@echo @rmdir /s /q > rm-r.cmd
@echo @del %1 %2 %3 %4 %5 %6 %7 %8 %9 > rm.cmd
@echo @rmdir %1 %2 %3 %4 %5 %6 %7 %8 %9 > rmdir.cmd
@echo @fc > sdiff.cmd
@echo @sort > sort.cmd
@echo @winrs > ssh.cmd
@echo @whoami > whoami.cmd
