#!/bin/bash
for i in `ls /var/log/remote/`; do
        cd /var/log/remote/$i;
        for j in `ls | egrep -v ".tar.gz"`; do
                dir01=`find . -name $j -mtime +7`
                if [ ! $dir01 = "" ]
                then
                        echo "$j is more than a week old - creating archive."
                        tar cvfz /var/log/remote/$i/$j.tar.gz /var/log/remote$i/$j
                        rm -rf /var/log/remote/$i/$j
                else
                        echo "$j is not more than a week old - skipping."
                fi
        done;
done;

