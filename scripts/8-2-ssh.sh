#!/bin/sh

export PEER_NAME=$(hostname)
export PRIVATE_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
echo $PRIVATE_IP $PEER_NAME

ssh-keygen -t rsa -b 4096 -C "popo1221@outlook.com"

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

