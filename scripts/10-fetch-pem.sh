#!/bin/sh

mkdir -p /etc/kubernetes/pki/etcd
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/ca.pem /etc/kubernetes/pki/etcd
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/client.pem /etc/kubernetes/pki/etcd
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/client-key.pem /etc/kubernetes/pki/etcd

