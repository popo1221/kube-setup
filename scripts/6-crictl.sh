#!/bin/sh

yum install -y go git
export GOPATH=/usr/local/
go get github.com/kubernetes-incubator/cri-tools/cmd/crictl

