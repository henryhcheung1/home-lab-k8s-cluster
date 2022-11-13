
### Example etcdctls commands
```bash
export ETCDCTL_API=3
etcdctl --endpoints http://192.168.1.65:2379 put foo bar
etcdctl --endpoints http://192.168.1.65:2379 get foo
```


#### etcd ansible playbook reference
- https://www.digitalocean.com/community/tutorials/how-to-set-up-and-secure-an-etcd-cluster-with-ansible-on-ubuntu-18-04#step-3-installing-etcd-on-the-managed-nodes
