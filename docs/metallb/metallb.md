<!-- ### Generate metallb-secret
```bash
./gen_secret.sh > metallb-secret.yaml
``` -->

### helm install
```bash
helm repo add metallb https://metallb.github.io/metallb
helm template --namespace metallb-system metallb metallb/metallb -f values.yaml > metallb-system.yaml
```
