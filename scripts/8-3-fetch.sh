#!/bin/sh

mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/ca.pem .
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/ca-key.pem .
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/client.pem .
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/client-key.pem .
scp root@10.211.55.13:/etc/kubernetes/pki/etcd/ca-config.json .

