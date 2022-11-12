#!/usr/bin/env bash

ETCD_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
echo $ETCD_IP > "/vagrant/local/etcd-ip"
