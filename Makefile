
# makefile targets

export LOCAL_DIR="local"

# make cluster
cluster:
	vagrant up
	./scripts/install_cilium.sh

destroy:
	vagrant destroy -f
	rm local/*

kubeconfig:
	export KUBECONFIG=local/k3s.yaml

# add a node

# delete a node

# verify cluster healthiness




# debugging commands

# agent1:
# 	vagrant up agent1


# test:
# 	TEST=${LOCAL_DIR} ./script.sh