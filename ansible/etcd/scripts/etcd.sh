#!/usr/bin/env bash

# ETCD_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
ETCD_IP=$(ip a |grep global | grep -v '10.0.2.15' | awk '{print $2}' | cut -f1 -d '/')
echo -n $ETCD_IP > "/vagrant/local/etcd-ip"
