#!/bin/sh

systemctl stop firewalld
systemctl disable firewalld

swapoff -a
swapoff -a && sysctl -w vm.swappiness=0
