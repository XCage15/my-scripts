#!/bin/bash
#Upload Limit from eth1
DEV_IN=eth1
tc qdisc del dev $DEV_IN root
tc qdisc add dev $DEV_IN root handle 1: cbq avpkt 1000 bandwidth 100mbit
tc class add dev $DEV_IN parent 1: classid 1:1 cbq rate 4Mbit allot 1500 prio 5 bounded isolated
tc filter add dev $DEV_IN parent 1: protocol ip prio 16 u32 match ip src 192.168.20.0/24 flowid 1:1
tc qdisc add dev $DEV_IN parent 1:1 sfq perturb 10

#Download Limit on eth1
DEV_Out=eth1
tc qdisc del dev $DEV_Out root
tc qdisc add dev $DEV_Out root handle 1: cbq avpkt 1000 bandwidth 100mbit
tc class add dev $DEV_Out parent 1: classid 1:1 cbq rate 4Mbit allot 1500 prio 5 bounded isolated
tc filter add dev $DEV_Out parent 1: protocol ip prio 16 u32 match ip dst 192.168.20.0/24 flowid 1:1
tc qdisc add dev $DEV_Out parent 1:1 sfq perturb 10