#!/bin/sh

cat >config.yaml <<EOF
apiVersion: kubeadm.k8s.io/v1alpha1
kind: MasterConfiguration
api:
    advertiseAddress: <private-ip>
etcd:
    endpoints:
    - https://<etcd0-ip-address>:2379
    - https://<etcd1-ip-address>:2379
    - https://<etcd2-ip-address>:2379
    caFile: /etc/kubernetes/pki/etcd/ca.pem
    certFile: /etc/kubernetes/pki/etcd/client.pem
    keyFile: /etc/kubernetes/pki/etcd/client-key.pem
networking:
    podSubnet: <podCIDR>
apiServerCertSANs:
- <load-balancer-ip>
apiServerExtraArgs:
    apiserver-count: "3"
kubernetesVersion: v1.10.2
EOF
