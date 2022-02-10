
.TL 
Unix Login Process

.AU 
Ian Stanley

.PP
Init (PID 1) will for a number of times (at least once for each getty to be used. Each forked init then exec's to run login. Once a user enters his/her credentials the login execs to run the user's shell. The shell forks to run each command using a fork-exec combo.

.PS
circle "\fBinit\fR" "\fIpid 1\fR"
circle "\fBinit\fR" "\fIpid 2\fR" at 1st circle +(0.75,1)
circle "\fBinit\fR" "\fIpid 3\fR" at 1st circle +(1,0) 
circle "\fBinit\fR" "\fIpid 4\fR" at 1st circle +(0.75,-1)
arrow "fork()" rjust above from 1st circle to 2nd circle chop 
arrow "fork()" above from 1st circle to 3rd circle chop 
arrow "fork()" rjust below from 1st circle to 4th circle chop 
E: circle "\fBlogin\fR" "\fIpid 3\fR" at 3rd circle +(1,0)
arrow "exec()" below 0.4 from 3rd circle to 5th circle chop 
F:circle "\fB/bin/sh\fR" "pid 3" at 5th circle +(1,0)
arrow up right 0.75 from F chop
arrow down right 0.75 from F chop
arrow "exec()" above from 5th circle to 6th circle chop 
circle "\fB/bin/sh\fR" "\fIpid 8\fR" at 6th circle +(1,0)
arrow "fork()" below from 6th circle to 7th circle chop 
circle rad 0.35 "\fBcc prog.c\fR" "\fIpid 8\fR" at 7th circle +(1.2,0)
arrow "fork()" above from 7th circle to 8th circle chop 
.PE

.PP
The first few steps of the login process all run with superuser privileges.


.PS
box "init(8)"; arrow; box "getty(8)";arrow;box "login(1)"
box "/etc/ttys" invis at 1st box +(0,-1) 
arrow from 4th box to 1st box chop
box "opens terminal" "prints 'login:'" "reads username" invis at 2nd box +(0,-1) 
.PE

.SH 
login(1) runs the following:
.IP
\(bu
getpass(3), has, compare to getpwnam(3)
.IP
\(bu
if successful registers login in system databases
.IP
\(bu
reads/displays various files eg. motd
.IP
\(bu
a user may be part of a numnber of supplementary groups, so login initialises group membership: initgroups(3), setgid(2), initialize environment
.IP
\(bu
chdir(2) to new home directory
.IP
\(bu
chown(2) of the terminal device
.IP
\(bu 
finally setuid(2) to user's uid and exec(3) a shell

.SH
The kernel explicitly creates init(8).

.LP
init(8) creates getty(8) using fork() and exec().

.LP
getty(8) execs (but does not fork) login(1).

.LP
login(1) execs (but doesn't fork) $SHELL.

.LP
And the $SHELL forks and execs commands.


.PP
init(8)		pid 1, ppid 0, euid 0
.PP
getty(8)		pid #, ppid 1, euid 0
.PP
login(1)		pid #, ppid 1, euid 0
.PP
$SHELL(1)		pid #, ppid 1, euid U
.PP
ls(1)			pid ##, ppid #, euid U

.PP
Where # is a unique PID no <>1 and ## a unique PID <> #


