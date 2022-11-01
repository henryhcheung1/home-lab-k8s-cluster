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

- Add add-node makefile target
- Start k3s from a config file? (bringup VM, template config file to VM k3s location, start k3s)
- Evaluate starting k3s with external DB or embedded DB


