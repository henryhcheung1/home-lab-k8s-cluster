
### Example etcdctls commands
```bash
export ETCDCTL_API=3
etcdctl --endpoints http://192.168.56.0:2379 put foo bar
etcdctl --endpoints http://192.168.56.0:2379 get foo
```
