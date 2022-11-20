
# makefile targets

# bring up VMs separately due to SSH timeout error when running 'vagrant up' to bring up all VMs simultaneously
cluster:
	vagrant up etcd0
	vagrant up master
	vagrant up agent

destroy:
	vagrant destroy -f
	rm local/*

kubeconfig:
# export KUBECONFIG=local/k3s.yaml
	cat local/k3s.yaml > ~/.kube/config

provision:
	vagrant provision

# add a node

# delete a node

# verify cluster healthiness

master:
	vagrant up master
