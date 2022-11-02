
# makefile targets

# make cluster
cluster:
	vagrant up

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
