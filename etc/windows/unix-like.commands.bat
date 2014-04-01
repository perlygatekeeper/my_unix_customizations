
Rem   RUN ME FROM A CMD WINDOW!!!

pause break out with Cntl-C and run this then restart me: mkdir %UserProfile%\bin; chdir %UserProfile%\bin

echo @findstr %1 %2 %3 %4 %5 %6 %7 %8 %9     > ack2.cmd
echo @cls                                    > c.cmd
echo "diantz/makecab + extrac32"             > cab.files.notes
echo @type %1 %2 %3 %4 %5 %6 %7 %8 %9        > cat.cmd
echo @chdir %1                               > cd.cmd
echo @cls                                    > clear.cmd
echo @copy %1 %2 %3 %4 %5 %6 %7 %8 %9        > cp.cmd
echo @date /T                                > date.cmd
echo @comp                                   > diff.cmd
echo @set                                    > env.cmd
echo @where /R %1 /F %2 %3 %4 %5 %6 %7 %8 %9 > find.cmd
echo find                                    > grep.cmd
echo @dir /n /q %1 %2 %3 %4 %5 %6 %7 %8 %9   > ll.cmd
echo @mklink %1 %2                           > ln-s.cmd
echo @mklink /H %1 %2                        > ln.cmd
echo @dir /n /O:D /T:W                       > lr.cmd
echo @dir /w %1 %2 %3 %4 %5 %6 %7 %8 %9      > ls.cmd
echo @dir /w                                 > lsd.cmd
echo @mkdir %1                               > mkdir.cmd
echo @type %1 %2 %3 %4 %5 %6 %7 %8 %9        > more.cmd
echo @rename %1 %2                           > mv.cmd
echo @tasklist /v                            > pidw.cmd
echo @popd                                   > po.cmd
echo @tasklist                               > ps.cmd
echo @pushd %1                               > pu.cmd
echo @chdir                                  > pwd.cmd
echo @rmdir /s /q                            > rm-r.cmd
echo @del %1 %2 %3 %4 %5 %6 %7 %8 %9         > rm.cmd
echo @rmdir %1 %2 %3 %4 %5 %6 %7 %8 %9       > rmdir.cmd
echo @fc                                     > sdiff.cmd
echo @sort                                   > sort.cmd
echo @winrs                                  > ssh.cmd
echo @whoami                                 > whoami.cmd

echo @echo ----- > kill.cmd
echo @echo use taskkill /? to learn about windows taskkill command >> kill.cmd
echo @echo or tskill /?  >> kill.cmd
echo @echo ----- >> kill.cmd
echo copy, xcopy, robocopy                   > windows_copy.notes.txt

@echo interesting commands: > interesting.txt
@echo robocopy >> interesting.txt
@echo reg >> interesting.txt
@echo replace >> interesting.txt
@echo rcp+rsh >> interesting.txt
@echo runas >> interesting.txt
@echo subst >> interesting.txt
@echo sxstrace >> interesting.txt
@echo systeminfo >> interesting.txt
@echo gpresult /SCOPE USER /R >> interesting.txt
@echo net1 >> interesting.txt
@echo netstat >> interesting.txt
@echo nslookup >> interesting.txt
@echo openfiles >> interesting.txt
@echo path >> interesting.txt
@echo tree >> interesting.txt
@echo ver >> interesting.txt
@echo subst sxstrace >> interesting.txt
@echo title >> interesting.txt
@echo winsat >> interesting.txt
@echo wmic >> interesting.txt
@echo Xwizard >> interesting.txt

echo  Setting the PATH environment variable.
echo
echo  Desktop -> "My Computer" -> Properties -> "Advanced system settings" ->
echo
echo  Button near the bottom of resulting window:  [ Environment Variables ... ]
echo
echo  +------------------------------------------+
echo  |                                          |
echo  |  User variables for parkes7              |
echo  |  +------------+-----------------------+  |
echo  |  |  Variable  |  Value                |  |
echo  |  |  A         |  Variable's value     |  |
echo  |  |  B         |  Variable's value     |  |
echo  |  |  C         |  Variable's value     |  |
echo  |  +------------+-----------------------+  |
echo  |  +---------+  +---------+  +---------+   |
echo  |  | New...  |  | Edit... |  | Delete  |   |
echo  |  +---------+  +---------+  +---------+   |
echo  + - - - - - - - - - - - - - - - - - - - - -+
echo  |  System variables                        |
echo  |  +------------+-----------------------+  |
echo  |  |  Variable  |  Value                |  |
echo  |  |  A1        |  Variable's value     |  |
echo  |  |  OS        |  Windows_NT           |  |
echo  |  |  PATH      |  C:\Perl\Site\bin\;...|  |   <= highlight this, and click Edit... button
echo  |  |  PATHEXT   |  .COM;.EXE;.BAT;.CMD..|  |
echo  |  +------------+-----------------------+  |
echo  |  +---------+  +---------+  +---------+   |
echo  |  | New...  |  | Edit... |  | Delete  |   |
echo  |  +---------+  +---------+  +---------+   |
echo  |                                          |
echo  +------------------------------------------+
echo  |               +---------+  +---------+   |
echo  |               |   OK    |  | Cancel  |   |
echo  |               +---------+  +---------+   |
echo  +------------------------------------------+
echo
echo
echo  +-------------------------------------------+
echo  | Edit System Variable                      |
echo  |                   +--------------------+  |
echo  |  Variable name:   | Path               |  |
echo  |                   +--------------------+  |
echo  |                   +--------------------+  |
echo  |  Variable value:  | %UserProfile%\bin\;|  |  <= prepend with '%UserProfile%\bin\;'
echo  |                   +--------------------+  |
echo  |                                           |
echo  |                +---------+  +---------+   |
echo  |                |   OK    |  | Cancel  |   |
echo  |                +---------+  +---------+   |
echo  +-------------------------------------------+
