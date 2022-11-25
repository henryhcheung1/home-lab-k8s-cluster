#!/usr/bin/env bash

# export AGENT_IP=$(ip a |grep global | grep -v '10.0.2.15' | awk '{print $2}' | cut -f1 -d '/')
export AGENT_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
export MASTER_IP=$(cat "/vagrant/local/master-ip")
export NODE_TOKEN=$(cat "/vagrant/local/node-token")

sudo mount bpffs -t bpf /sys/fs/bpf

curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN="${NODE_TOKEN}" INSTALL_K3S_EXEC="--no-flannel --node-ip=${AGENT_IP} \
--node-external-ip=${AGENT_IP} --node-label storage-node=true --node-taint storage-node=true:NoExecute" sh -
