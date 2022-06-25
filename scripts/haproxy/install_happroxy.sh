#!/bin/sh

haproxy_config='/etc/haproxy/haproxy.cfg'

sudo apt install haproxy -y

cat /tmp/haproxy.cfg | sudo tee $haproxy_config

sudo systemctl restart haproxy
