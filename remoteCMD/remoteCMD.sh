#!/bin/bash
#Script for running command to remote shell using ssh
#Remote machine and local maching must have pre configured with RSA key authentication.
########################################################
#Last modified on 20140223 by tayzar.lwin@frontiir.net #
########################################################

#Defined hosts name in /etc/hosts first
#Command syntax ./checkICMP.sh host1 host1 .. host9


logfile=./log/remoteCMD.log
user=$USER

#Put your desired command in mycommand.sh
MyScript="./mycommand.sh"

#Get remote host from INPUT
Hosts="$@"

# Run as root, of course.
if [[ "$UID" -ne "$ROOT_UID" ]]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi


for RemoteHost in ${Hosts} ; do
 echo "Checking $RemoteHost status"

 #Check Host with ICMP first
 ping -c 4 $RemoteHost
 if [[ $? -eq 0 ]]; then

    echo "$RemoteHost is alive on " $(date) | tee -a $logfile

# Then run the script on remote host using ssh
    ssh -l $user $RemoteHost "bash -s " < $MyScript | tee -a $RemoteHost.remoteCMD.log
else
    echo "$RemoteHost is down on " $(date) | tee -a $logfile

 fi

done
exit 0
