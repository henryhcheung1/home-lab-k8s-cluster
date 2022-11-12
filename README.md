# home-lab-k8s-cluster

multi master / worker k3s running on virtualbox VMs

Cluster Components:

- Metallb
- Traefik ingress controller (or Envoy Contour)
- Cilium CNI
- Flatcar Linux
- CSI (Ceph?, Longhorn)
- Open Policy Agent (OPA)
- Service mesh (Istio?)


TODO:

- Add add-node makefile target
- Start k3s from a config file? (bringup VM, template config file to VM k3s location, start k3s)
- Start k3s with external etcd (or [SQL db?](https://learnk8s.io/etcd-kubernetes#:~:text=of%20watch%20queries.-,Replacing%20etcd,-etcd%20works%20terrifically)) with mutual TLS
- Add multiple master nodes support

- Fix etcd cluster static discovery
- Replace vagrant with Terraform

### Setup
```
mkdir local
vagrant up
```
