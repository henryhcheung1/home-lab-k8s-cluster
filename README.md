# home-lab-k8s-cluster

multi master / worker k3s running on virtualbox VMs

Cluster Components:

- Metallb
- Traefik ingress controller (or Envoy Contour)
- Cilium CNI
- Flatcar Linux
- CSI (Ceph?)
- Open Policy Agent (OPA)


TODO:

- Replace static IPs with DNS records
- Need to fix node not ready after cluster restart 
- Evaluate starting k3s with external DB or embedded DB
- Replace everything with k3sup https://github.com/alexellis/k3sup
