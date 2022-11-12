
# makefile targets

# bring up VMs separately due to SSH timeout error when running 'vagrant up' to bring up all VMs simultaneously
cluster:
	vagrant up etcd0
	vagrant up master

destroy:
	vagrant destroy -f
	rm local/*

kubeconfig:
	export KUBECONFIG=local/k3s.yaml

provision:
	vagrant provision

# add a node

# delete a node

# verify cluster healthiness

master:
	vagrant up master
