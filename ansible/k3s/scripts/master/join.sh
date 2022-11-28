sudo mount bpffs -t bpf /sys/fs/bpf

# export SERVER_IP=$(ip a |grep global | grep -v '10.0.2.15' | awk '{print $2}' | cut -f1 -d '/')
export SERVER_IP=$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')

export MASTER_IP=$(cat "/vagrant/local/master-ip")
export NODE_TOKEN=$(cat "/vagrant/local/node-token")
export ETCD_IP=$(cat "/vagrant/local/etcd-ip")

curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN="${NODE_TOKEN}" INSTALL_K3S_EXEC="server --flannel-backend=none \
--no-flannel --node-ip=${SERVER_IP} --node-external-ip=${SERVER_IP} --bind-address=${SERVER_IP} --node-taint CriticalAddonsOnly=true:NoExecute \
--disable servicelb --datastore-endpoint=http://${ETCD_IP}:2379" sh - 

# run on every master
echo $SERVER_IP >> "/vagrant/local/master-ip"
