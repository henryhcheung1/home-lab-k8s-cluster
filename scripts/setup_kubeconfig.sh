#!/bin/sh

localhost='127.0.0.1'
k8s_master_lb='192.168.1.32'

vagrant ssh kubemaster1 -c "sudo cat /etc/rancher/k3s/k3s.yaml" > ~/.kube/config

sed -i "s/${localhost}/${k8s_master_lb}/" ~/.kube/config
