sudo mount bpffs -t bpf /sys/fs/bpf

export MASTER_IP=$(ip a |grep global | grep -v '10.0.2.15' | awk '{print $2}' | cut -f1 -d '/')

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-backend=none \
--no-flannel --tls-san ${MASTER_IP} --node-ip=${MASTER_IP} --node-external-ip=${MASTER_IP} \
--bind-address=${MASTER_IP} --disable servicelb" sh - # --disable traefik

echo $MASTER_IP > /vagrant/local/master-ip
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/local/node-token
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/local/k3s.yaml
sudo sed -i -e "s/127.0.0.1/${MASTER_IP}/g" /vagrant/local/k3s.yaml
