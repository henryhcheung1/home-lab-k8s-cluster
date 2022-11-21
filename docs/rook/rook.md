
### template rook operator manifests
```bash
helm template --namespace rook-ceph rook-ceph rook-release/rook-ceph -f values.yaml > rook-operator.yaml
```

### operator helm chart values:
- https://github.com/rook/rook/blob/master/Documentation/Helm-Charts/operator-chart.md


### rook-ceph best practices
- https://documentation.suse.com/sbp/all/html/SBP-rook-ceph-kubernetes/index.html