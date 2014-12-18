#!/bin/bash
#######################################
#Modified by tayzar.lwin@frontiir.net #
#######################################

#Clear the old firewall rules
iptables -F

#Define Default Policy
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

#Define Local Trusted Network 
Mgmt_Network=$(/sbin/ip route | grep 'eth0' | awk '{print $1}' | grep -v default)

#Assuming Firewall is running on eth0, change the interface name if it's not for eth0
#Get Interface IP Address
FW_IP=$(/sbin/ifconfig eth0 |  grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')


#Allow SSH InBound first
iptables -A INPUT -p tcp  -s $Mgmt_Network -d $FW_IP --dport 22 -j ACCEPT

#Allow loopback
iptables -A INPUT -p all -i lo -j ACCEPT

#Allow all ICMP Traffic
iptables -A INPUT -p icmp -j ACCEPT

#Allow Incoming Web Server Traccfic
iptables -A INPUT -p tcp -s $Mgmt_Network -d $FW_IP --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -s $Mgmt_Network -d $FW_IP --dport 443 -j ACCEPT

#Allow Incoming mysql connection only from Local Network
#iptables -A INPUT -p tcp -s $Mgmt_Network -d $FW_IP --dport 3306 -j ACCEPT

#Allow Incoming radius auth & acct connection only from Local Network
#iptables -A INPUT -p udp -s $Mgmt_Network -d $FW_IP --dport 1812 -j ACCEPT
#iptables -A INPUT -p udp -s $Mgmt_Network -d $FW_IP --dport 1812 -j ACCEPT


#Allow Return ESTABLISHED Package
iptables -A INPUT -p all -s 0/0 -d $FW_IP -m state --state RELATED,ESTABLISHED -j ACCEPT

#Drop everything else at LAST
iptables -A INPUT -j DROP
