#!/bin/sh

cat >/etc/kubernetes/manifests/etcd.yaml <<EOF
apiVersion: v1
kind: Pod
metadata:
labels:
    component: etcd
    tier: control-plane
name: etcd1
namespace: kube-system
spec:
containers:
- command:
    - etcd --name etcd1- --data-dir /var/lib/etcd - --listen-client-urls http://localhost:2379 - --advertise-client-urls http://localhost:2379 - --listen-peer-urls http://localhost:2380 - --initial-advertise-peer-urls http://localhost:2380 - --cert-file=/certs/server.pem - --key-file=/certs/server-key.pem - --client-cert-auth - --trusted-ca-file=/certs/ca.pem - --peer-cert-file=/certs/peer.pem - --peer-key-file=/certs/peer-key.pem - --peer-client-cert-auth - --peer-trusted-ca-file=/certs/ca.pem - --initial-cluster etcd1=https://10.211.55.13:2380,etcd2=https://10.211.55.14:2380,etcd3=https://10.211.55.14:2380 - --initial-cluster-token my-etcd-token - --initial-cluster-state new
    image: k8s.gcr.io/etcd-amd64:3.1.13
    livenessProbe:
    httpGet:
        path: /health
        port: 2379
        scheme: HTTP
    initialDelaySeconds: 15
    timeoutSeconds: 15
    name: etcd
    env:
    - name: PUBLIC_IP
    valueFrom:
        fieldRef:
        fieldPath: status.hostIP
    - name: PRIVATE_IP
    valueFrom:
        fieldRef:
        fieldPath: status.podIP
    - name: PEER_NAME
    valueFrom:
        fieldRef:
        fieldPath: metadata.name
    volumeMounts:
    - mountPath: /var/lib/etcd
    name: etcd
    - mountPath: /certs
    name: certs
hostNetwork: true
volumes:
- hostPath:
    path: /var/lib/etcd
    type: DirectoryOrCreate
    name: etcd
- hostPath:
    path: /etc/kubernetes/pki/etcd
    name: certs
EOF
