
## Commands 

### View api server certificate from k8s master node
```bash
openssl s_client -connect localhost:10250 2>/dev/null | openssl x509 -noout -text
```

## Troubleshooting

### k8s node status Not Ready
```bash
# on k8s worker node, as root, check logs
systemctl status k3s-agent
sudo journalctl -u k3s-agent -f # /tmp/token does not exist

# fetch token from master
scp -o StrictHostKeyChecking=no root@kubemaster1:/var/lib/rancher/k3s/server/token /tmp/token

# check node status
```

