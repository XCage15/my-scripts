#!/bin/bash

#Disabled root login fom ssh

cat /dev/null > /etc/ssh/sshd_config
cp ./sshd_config > /etc/ssh/sshd_config

service ssh restart


useradd -d /home/tayzarlwin -s /bin/bash -m tayzarlwin 
adduser tayzarlwin sudo
mkdir  /home/tayzarlwin/.ssh
touch /home/tayzarlwin/.ssh/authorized_keys
cat <<EOF >/home/tayzarlwin/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyiUZUL0DKdyof42TOK3sByD6+GYql42zI8Q6WPxEDfx+NEQH0APKU+0rRKlhYC3k7+sSsJXfZVaNFpRRAZBeXbdCHobcLDd3ToSJ+d/iRc7yvJBYyqUJ/wz8U2Nt3g+FCVUmn/JUaNnrtQ2myHxuCSuocptCNVRwqrQajKfEh2oP3SLw+zXVg3BZ4awVu7v/fxoRrqqWTT1RKkX9vjVuoyxdyxsotqzJ3slY0Vt9ZbsffV5qOor3hTkecYq9qNT7MvyO72VLuJ/dBKoZmXL2NX1eptf5VvQtO97SkU1k6DFd7rupQIlTnDtuK30OmW+dj2Y8po+/3ycI3W4blGwND tayzarlwin@ssh-server 
EOF


useradd -d /home/minhtutwin -s /bin/bash -m minhtutwin
adduser minhtutwin sudo
mkdir /home/minhtutwin/.ssh
touch /home/minhtutwin/.ssh/authorized_keys
cat <<EOF >/home/minhtutwin/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUNOREzoNduWilIHtCMTAzhr6wTVUuE4EZuQNOL0Es5ZxCl16qKucDzLb2E50+ChZCsUS0xMowVg4G9DBUXNFTdkkAGmoEbPu9NUf33JanKffU7n1oKoJFFeLvCswkDRjpRcyVMaZ29wAiXBQjBRxHqAa5kDDj9kKdlNK5eU8arVKNMOr0IFjRd5Y1sTpZ0uytLo8CS2lAFYN4//i3OwFn/PHeG1VwzsBPXWfw1MGMpfg5wOJSquwIImhmeCKnP22u0thbsl/Aqz/XT2NFpN/IW+gNx4+S1eyC+xewJEcFWb1zn8ngOzHE6r4nKePEX5p7UhkNcCWpJsOcBX6XGiWd minhtutwin@ssh-server
EOF


useradd -d /home/aungkozaw -s /bin/bash -m aungkozaw
adduser aungkozaw sudo
mkdir /home/aungkozaw/.ssh
touch /home/aungkozaw/.ssh/authorized_keys
cat <<EOF >/home/aungkozaw/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKTa73vP+3NtpUTVdp2YmwoP5ebjv+0iv46vrWsmob2i3ajy1E78QZDElWozuv4aZkU+HlvwUlgI8OXm7mLrpFKgmjqgtmJ6NdI29bs+xJsSb4rG5+rl4wveGDlmq/ioVOPm3E9jEAOfDJHWEuCRSZ6bZULbzH+ppHVhv1P+JWMIKU8KL2Aoy9thebHGvGMeuThjOyVG6SZ4630yfmX7mdhr6tthCE0m+FsU28/ZV4TcnftpxPBaYgd66act57OxJvhpilHktdffYe4U+aTSL5cWv2kAzD+vW3ZDx6B+ignft/1JD3aMy24b7jC+sw42O1Za/UhkcVC/VYV6zO8tDd aungkozaw@ssh-server
EOF




