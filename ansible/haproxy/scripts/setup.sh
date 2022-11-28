#!/usr/bin/env bash

export HAPROXY_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
echo $HAPROXY_IP >> "/vagrant/local/haproxy-ip"
