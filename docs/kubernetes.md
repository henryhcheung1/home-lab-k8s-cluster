
### dusplay node taints
```bash
kubectl get nodes -o json | jq '.items[].spec.taints'
```
