#!/bin/bash
cat userLists | while read line
do
echo "Creating user $line"
useradd -s /bin/bash -m $line
echo " Creating ssh directory" 
mkdir  /home/$line/.ssh
touch /home/$line/.ssh/authorized_keys
echo "Adding frontiir public key for ssh authentication "
cat <<EOF >>/home/$line/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAmCbcbJm5Mu66jRW6+4GEStndB1p0vbK9RFHy8vEOmD/9GQHzu8lXEF1/kdSZU+y7BD2RdEfEoUD6cS3YcdWKb20VQ3lu7Ua/ebkQ7IE6xzfoQiX8FHPWgce/DB17lE1FgCr4xzxrByYeX1tj9NqbghKmCMUGaRh9zk12PqO9pM0= frontiir-public.ppk
EOF
chown $line:$line /home/$line/.ssh -R


done 
