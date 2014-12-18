#!/bin/bash
if [ "$1" == "" ]; then
echo "Usage $0 VM-NAME"
exit 1
fi
sdomid=$(xe vm-list params=dom-id name-label=$1 | awk '{printf $5}' )
sresuuid=$(xe vm-list params=resident-on name-label=$1)
sdomip=$(xe pif-list management=true params=IP host-uuid=$sresuuid)
svncport=$(xenstore-read /local/domain/$sdomid/console/vnc-port)
echo "VM Name= $1"
echo "DOM ID= $sdomid"
echo "VM is resident on UUID=$sresuuid"
echo "VM ($1) vnc port= $svncport"