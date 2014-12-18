#! /bin/bash
#This script will backup configuration files 
################################################
#Modified by tayzar.lwin@frontiir.net 20140603 #
################################################

# What to backup. 
backup_files="/etc/network/interfaces /etc/ssh /etc/pam.d/ /etc/passwd /etc/blabla  "
# Where to backup to.

dest="/mnt/backup"

# Create archive filename.
day=$(date +%F)
date=$(date)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"

# Backup the files using tar.
tar czfP $dest/$archive_file $backup_files

# Print end status message.
echo "Backup finished"

#Write Log file 
echo "Last backup Finished on" $date  >>  $dest/$hostname-config-backup.log


