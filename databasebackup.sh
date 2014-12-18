#!/bin/bash
#Backup shell script for mysql database
#The script will backup all databases to NFS mount point
#Mount point need to setup successfully before running script
################################################
#Modified by tayzar.lwin@frontiir.net 20130908 #
################################################
#Backup Destination
dest="/mnt/backup"


#Get date and hostname to be used in Backup file name
date=$(date)" 
day=$(date +%A)" 
hostname=$(hostname -s)" 

#Create directory if not exist
if [! -d $dest/$day] 
        then mkdir $dest/$day 
        chmod 644 $dest/$day -R 
else echo "Directory already created" 
fi 
#Get date and hostname to be used in Backup file name
date=$(date)
day=$(date +%A)
hostname=$(hostname -s)

#Create directory if not exist
if [! -d $dest/$day]
        then mkdir $dest/$day
        chmod 644 $dest/$day -R
else echo "Directory already created"  
fi 

#Get databases names
DBLIST=`mysql -e "show databases;" | tail -n +2`
for DBNAME in ${DBLIST[@]}
do
#Name the backup files
DBBKUP=$DBNAME.'sql'

#Skip lock tables
if [ "${DBNAME}" == "information_schema" ] || [ "${DBNAME}" == "performance_schema" ];
 then
        additional_mysqldump_params="--skip-lock-tables"
  else
        additional_mysqldump_params=""
  fi

#Dump mysql database to dest
/usr/bin/mysqldump  $additional_mysqldump_params $DBNAME > $dest/$day/$DBBKUP
gzip $dest/$day/$DBBKUP
done
echo "Last backup Finished on" $date >> $dest/$day/Backup.log
#List Backup files
ls -lh $dest/$day