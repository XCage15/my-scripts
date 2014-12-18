#!/bin/bash
ppid=""
myhome=$HOME/.reverse
svcState=$myhome/reverse.state
lhost=127.0.0.1
google=http://www.google.com
logfile=$myhome/remote-logs.log
rkey=$myhome/networkers-openssh.pem
rhost=secured.frontiir.net
ruser=networker
rstring=$RPORT:$lhost:$LPORT
RPORT=55566
LPORT=22
result=""
iresult=""

checkInternet() {
echo "Checking internet status..."
iresult=$(curl $google)
if [ "$iresult" = "" ]; then
     date >> $logfile
     echo "Internet is not reachable." | tee -a $logfile
     if [ -e $svcState ]; then
          rm $svcState
     fi
     exit 0
fi
}

createRTunnel() {
     # verify local site
     #checkLocalSite
     # check Internet status
     checkInternet
     date >> $logfile
     echo "Start the tunnel...." | tee -a $logfile
    /usr/bin/ssh -i $rkey -f -N -R$rstring  -o TCPKeepAlive=yes -o ServerAliveCountMax=100 -o ServerAliveInterval=10 -T $ruser@$rhost -p 50011
    if [[ $? -eq 0 ]]; then
        date >> $logfile
        echo Reverse tunnel created successfully | tee -a $logfile
          # cleaning previous state if exists
          if [ -e $svcState ]; then
               rm $svcState
          fi
    else
        date >> $logfile
        echo An error occurred creating reverse tunnel -  RC was $? | tee -a $logfile
    fi
}

if [ ! -e $rkey ]; then echo "Missing key: $rkey" | tee -a $logfile; fi
if [ ! -d $myhome ]; then mkdir -p $myhome; fi
if [ ! -e $logfile ]; then touch $logfile; fi
# pre-check
result=$(ps -ef | grep ssh | grep $RPORT | grep -v grep)
if [ ! "$result" ]; then
        date >> $logfile
        echo Creating new tunnel connection | tee -a $logfile
        createRTunnel
else
          # post-check - start self healing - health check
        date >> $logfile
        ppid=$(ps -ef | grep $RPORT | grep -v grep | awk '{ print $2 }')
        echo Tunnel process PID = $ppid is active and checking for session status on remote site. | tee -a $logfile
          pppid=""
          # cleaning previous checker id
          pppid=$(ps -ef | grep ssh | grep netstat | awk '{ print $2 }')
          if [ "$pppid" ]; then
               kill -9 $pppid
          fi
        ret=$(/usr/bin/ssh -i $rkey -T  $ruser@$rhost -p 50011 "sudo netstat -antp | grep $RPORT | grep ssh")
          echo "return: $ret"
        if [ "$ret" != "" ]; then
                echo "Tunnel is active on remote host and already established." | tee -a $logfile
        else
               if [ -e $svcState ]; then
                    echo "Previous check state found." | tee -a $logfile
                echo "Tunnel is not active on remote host." | tee -a $logfile
                echo "Killing on current process on local" | tee -a $logfile
                ppid=$(ps -ef | grep $RPORT | grep -v grep | awk '{ print $2 }')
                kill -9 $ppid
                createRTunnel
               else
                    touch $svcState
                    echo "Wait for next interval to restart tunnel." | tee -a $logfile
               fi
        fi
fi
