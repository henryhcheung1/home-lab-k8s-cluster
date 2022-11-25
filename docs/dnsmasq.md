### dnsmasq

```bash
systemctl status dnsmasq

# set dns record mappings in this file
/etc/hosts

# use local DNS server 
# nameserver 192.168.1.28
nano /etc/resolvconf/resolv.conf.d/base
sudo resolvconf -u
cat /etc/resolv.conf
```
