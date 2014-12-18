#!/bin/bash
#A Script for XEN Pool database backup
log_dir="/var/run/sr-mount/32f90be1-5ef7-2a69-5a73-38ab284ec43e"
logfile="$log_dir/pool_db_bkp.log"
xe pool-list | grep name-label | awk '{ print $4 }' | while read poolName 
do
bkpDate="$date +%F"
bkpData="$poolName_$bkpDate.bkp"

	date >> logfile
echo " Backing up pool database "  |  tee -a $logfile
cd $log_dir
xe pool-dump-database file-name=$bkpData

gzip -f $bkpData
