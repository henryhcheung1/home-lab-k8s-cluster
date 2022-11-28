# home-lab-k8s-cluster

multi master / worker k3s running on virtualbox VMs

Cluster Components:

- Metallb
- Traefik ingress controller (or Envoy Contour)
- Cilium CNI
- Flatcar Linux
- CSI (Rook + Ceph) - require NTP
- Open Policy Agent (OPA)
- Service mesh (Istio?)
- ArgoCD (Kustomization + jsonnet/ksonnet)

DONE:
- Add Cilium CNI
- Replace embedded etcd with external etcd


TODO:

- Add multiple master nodes support + master LB
- Add CSI
- Start k3s from a config file? (bringup VM, template config file to VM k3s location, start k3s)
- Fix etcd cluster static discovery for multi etcd cluster (issue with Ansible)
- Add mutual TLS between external multi etcd k3s (or [SQL db?](https://learnk8s.io/etcd-kubernetes#:~:text=of%20watch%20queries.-,Replacing%20etcd,-etcd%20works%20terrifically)) 
- Add add server / agent node makefile target
- Chaos engineering testing
- Cluster backups with Velero


### Setup
```
mkdir local
make cluster
```


### Boot Order
```bash
# VM
etcd
master (server)
worker (agent)

# K8s
cilium
metallb

```



etcd(s)
master(s) - update haproxy config with k8s master IPs
haproxy
workers
storage
