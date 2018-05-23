# 

## 第一步配置系统
1. 关掉swap以及SELinux   
```bash
# 1. 编辑/etc/fstab，注释掉swap
# 2. 关掉swap
swapoff -a
swapoff -a && sysctl -w vm.swappiness=0

# /etc/selinux/config
# SELinux = disabled
```

2. 关掉防火墙
```bash
systemctl stop firewalld
systemctl disable firewalld
# vim /etc/selinux/config
# SELINUX=disabled
```

3. 配置iptables
```bash
# /etc/sysctl.d/k8s.conf
cat <<EOF > /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
```

4. 配置yum repo，并更新
```bash
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# yum makecache
# yum update -y
```

5. 安装docker
```bash
# step 1: 安装必要的一些系统工具
yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
yum makecache fast
yum -y install docker
# Step 4: 开启Docker服务
service docker start
```

6. 安装crictl
```bash
yum install -y go git
export GOPATH=/usr/local/
go get github.com/kubernetes-incubator/cir/crictlgo get github.com/kubernetes-incubator/cri-tools/cmd/crictl
```

7. 安装kubelet,kubeadm,kubectl
```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet
```

## 第二步配置

