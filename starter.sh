#!/bin/bash


while
(( $(ps -ef | grep -v grep | grep freeradius | wc -l) < 1 ))
do

pingo=$(/bin/ping -c 1 172.16.64.38 | grep 'received' | awk -F',' '{print $2}' | awk '{print $1}')
echo "$pingo"
if       [ $pingo -eq 1 ]; then
	sleep 5
#        echo "Get reply from MySQL1. I will continue to check anoter server."
	pingo=$(/bin/ping -c 1 172.16.64.39 | grep 'received' | awk -F',' '{print $2}' | awk '{print $1}')
       if [ $pingo -eq 1 ]; then
#	echo "Get reply from MySQL2. I will start Freeradius!!!"
	
	service freeradius start
	else 
	sleep 5
	echo " I shoud not start Freeradius "
	
       fi
 	else
	sleep 5
	echo "I have to Recheck Again!!!"
       
fi
        
done  



