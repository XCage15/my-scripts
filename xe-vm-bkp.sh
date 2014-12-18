#!/bin/bash
dstURL=/var/run/sr-mount/970854d0-6aa5-9007-801d-23af521b472b/backup
strdate=$(date "+%F-%H-%M-%S")
allmetas=$(xe vm-list)

cd $dstURL

echo $allmetas > allmetas-$strdate.list
vmlist=$(xe vm-list | grep uuid | awk '{print $5}')
for vm in $vmlist
do
xe vm-export metadata=true vm=$vm filename=$vm-$strdate.bk
done
#echo $vmlist
