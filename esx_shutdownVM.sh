#!/bin/sh

#############################################################################
#Scheduled shutdown script for every Virtual Machines and Hypervisors		#
#It will try to shutdown the All the VM, then Hypervisors, and NAS at last. #
#############################################################################

esxcli vm process list | grep 'World ID' | awk '{ print $3 }' | while read serverList
do echo $serverList 
#esxcli vm process kill --type=hard --world-id=$serverName
done 

