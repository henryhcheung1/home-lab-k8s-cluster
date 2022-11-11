
## useful cilium cli commands

```bash
# https://docs.cilium.io/en/stable/gettingstarted/k3s/

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml cilium install

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml cilium status --wait

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml cilium connectivity test

sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml cilium uninstall
```
