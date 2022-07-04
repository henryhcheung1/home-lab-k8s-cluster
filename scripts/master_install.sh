#!/bin/sh

# Deploy keys to allow all nodes to connect each others as root
mv /tmp/id_rsa*  /root/.ssh/

chmod 400 /root/.ssh/id_rsa*
chown root:root  /root/.ssh/id_rsa*

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 400 /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys

# Add current node in /etc/hosts
echo "127.0.1.1 $(hostname)" >> /etc/hosts

# Get current IP adress to launch k3S
current_ip=$(/sbin/ip -o -4 addr list enp0s8 | awk '{print $4}' | cut -d/ -f1)

master_lb_ip="192.168.1.32"

# If we are on first node, launch k3s with cluster-init, else we join the existing cluster
if [ $(hostname) = "kubemaster1" ]
then
    curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san ${master_lb_ip} --tls-san ${hostname} --bind-address=${current_ip} --advertise-address=${current_ip} --node-ip=${current_ip} --node-taint CriticalAddonsOnly=true:NoExecute --disable servicelb --flannel-backend=none --disable-network-policy # --disable traefik
else
    echo "10.0.0.11  kubemaster1" >> /etc/hosts
    scp -o StrictHostKeyChecking=no root@kubemaster1:/var/lib/rancher/k3s/server/token /tmp/token
    curl -sfL https://get.k3s.io | sh -s - server --server https://${master_lb_ip}:6443 --token-file /tmp/token --tls-san ${master_lb_ip} --tls-san ${hostname} --bind-address=${current_ip} --advertise-address=${current_ip} --node-ip=${current_ip} --node-taint CriticalAddonsOnly=true:NoExecute --disable servicelb --flannel-backend=none --disable-network-policy # --disable traefik
fi

# Mount eBPF Filesystem for cilium
sudo mount bpffs -t bpf /sys/fs/bpf
