#!/bin/bash
##############################################
#This script will check the availability of Coova-Chilli1 (Master Captive Portal) 
# with ICMP and if the server is down, it would activate the Interface of Standby 
# Coova-Chilli Server to take place the Captive Portal 
#
logfile=/var/log/ChilliCheck.log

#Check Coova-Chilli Management Interfaces with ICMP 

 ping -c 4 172.16.64.20
 if [[ $? -eq 0 ]]; then

    echo "Coova-Chilli1 is alive on " $(date) 	

exit 0 	
# If Master Server is down, activate the VIF on Standby server.
else  

    echo "Master Coova-Chilli Server is down on " $(date) | tee -a $logfile
	
	echo "Activating the Coova-Chilli WAN Interface"  | tee -a $logfile
	 ifup eth0
	 
	 echo "Activating the Coova-Chilli DHCP Relay Interface"  | tee -a $logfile	 
	 ifup eth2
	 
	 echo "Activating the Coova-Chilli Mobile Clients Interface"  | tee -a $logfile
	 ifup eth3
	 
	 echo "Activating the Coova-Chilli CPE Clients Interface"  | tee -a $logfile
	 ifup eth4
	 
	 #Start Coova-Chilli 
	 service coova-chilli start
fi
