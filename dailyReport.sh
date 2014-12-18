#!/bin/bash
# Add a crontab to run at 2 AM
#0 2 * * * /$PATH/dailyReport.sh
dir=$(pwd)
host=$(hostname -f)
echo "Daily Report for $host" > $dir/report.txt
date >> $dir/report.txt
# Check hard drive space
echo "Hard drive space:" >> $dir/report.txt
df -h >> $dir/report.txt
# List the users that are logged in
echo "Users currently logged in:" >> $dir/report.txt
who >> /$dir/report.txt
# List currently running processes
echo "Running processes:" >> $dir/report.txt
ps -e >> $dir/report.txt

# Send the email
cat $dir/report.txt | mail -s " $host : Daily server information" system.engineers@wisp.net
# Delete the file we created
rm $dir/report.txt
