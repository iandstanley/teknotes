.TL 
Job Control
.AU 
Ian Stanley
.SH 
Process Groups
.PP
.PS
Leftbox: box "" "" "" "" "" "" ""  ""  "\fIbackground" "process group\fR" dotted width 1.5 height 2;
box "login" "shell" at 1st box  +(0,0.5)
Centrebox: box "" "" "" "" "" "" "" "" "\fIbackground" "process group\fR" dotted width 2 height 2 at Leftbox +(2,0)
box "proc1" "shell" at Centrebox  +(-0.5,0.5)
box "proc2" "shell" at Centrebox +(0.5,0.5)
Rightbox: box "" "" "" "" "" "" "" ""  "\fIforeground" "process group\fR" dashed width 2 height 2 at Leftbox +(4.3,0)
box "proc3" at Rightbox  +(-0.4,0.5)
box "proc4" at Rightbox  +(0.4,0.5)
box "proc5" at Rightbox  +(0,-0.1)
Ellipse: ellipse "controlling" "terminal" width 1.5 height 1.2 at 1st box +(2,-2)
arrow "" "" "modem disconnect" below rjust "HUP signal" below rjust from Ellipse.left to Leftbox.bottom
arrow "" "" "terminal I/O" below ljust "& generated signals" below ljust from Ellipse.right to Rightbox.bottom
.PE
.LP
The above diagram represents the following commands entered at the shell.

.IP
$ proc1 | proc2
[1] 10306
.IP
$ proc3 | proc4 | proc5
.LP
We can see the shell is in it's own process group:
.IP 
$ ps -o pid,ppid,pgid,sid,comm
.TS
l l l l l.
PID	PPID	PGID	SID	COMMAND
41	711	41	41	-sh
753	41	753	41	ps
.TE
.LP
Here the shell (\fIpid 41\fR) forks to create ps and then sets the PGID
with \fIsetpgid(2)\fR to create a new foreground process group.  
After 'ps' completes it exits. It's exit status (\fI$?\fR) will linger until
it's parent process asks for it. The shell will just sit there and
wait blocking any other input so that when the child process terminates
it may immediately read the exit status.
.LP
If we run a process in the background with:
.IP
$ /bin/sleep 10 & 
.LP
We see \fIsleep(1)\fR being placed in it's own process group. When this
command completes nothing much happens to 'ps' since the shell
didn't wait for it as it was running in the background. But if we
hit return again the shell reports the background process had
completed.
.IP
$
.br
[2] Done	/bin/sleep 10 & 
.br
$
.LP 
The shell must have called \fIwait(2)\fR to get the status information
of the \fIsleep(3)\fR process, but clearly it didn't block waiting for
the process. So how did the shell know to call \fIwait(2)\fR on it's child
process? 
.LP
The answer: when the background process terminated it
generated a signal to notify it's parent (\fISIGCHILD\fR). The parent is
setup to call \fIwait(2)\fR when it receives \fISIGCHILD\fR. At some point the
login shell must have allocated a controlling terminal by calling
\fItcsetpgrp(3)\fR.
.SH 2
Listing running jobs
.LP
We can list all running jobs with the 'job' command:
.IP
$ job -l 
.SH 2
Restarting a stopped job
.LP
We can put a stopped job into a running state in the background with the '\fIbg\fR' command.
.IP
$ bg %2
.LP
Note:  %, %+ or %% refers to the current job; %- to the previous.
.SH 2
Bringing a job to the foreground:
.LP
We can also bring any background job to the foreground using the '\fIfg\fR' command.
.IP
$ fg %2
.SH 2
Suspending a process
.LP
We can suspend any process, including one running in the background by sending it the \fITSTOP\fR signal:
.IP
$ kill -TSTOP 2013
.SH 2
Conituing a process
.LP
We can continue a stopped job by sending a \fICONT\fR signal:
.IP
$ kill -CONT 2013
.SH 2
Killing a process
.LP
We can simply kill the job with:
.IP
$ kill 2013

