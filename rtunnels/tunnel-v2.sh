#!/bin/bash
#This script is intended to make SSH Reverse Tunnel

echo "Checking Internet Status...."
result="200"
iresult=$(curl -sL -w "%{http_code}\\n" "http://www.google.com/" -o /dev/null)
port=19991
host="199.180.133.151"
myhome=$HOME/.reverse
key=$myhome/key.pem

if [ "$iresult" = "$result" ]; then
echo "    Internet is good. "

if (( $(ps -ef | grep -v grep | grep $port | wc -l) > 0 ))
then
echo " Tunnel is already running "
else

/usr/bin/ssh -i $key -fN -R $port:localhost:22 root@$host
echo "Reverse Tunnel is start running!!!"
fi

else
echo  "    Internet is bad. Tunnel could not start..."
fi