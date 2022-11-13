
### Virtualbox networking

```bash
+-----------+-------------+-------------+----------------+----------------+
|           | VM <-> Host | VM1 <-> VM2 | VM -> Internet | VM <- Internet |
+-----------+-------------+-------------+----------------+----------------+
| HostOnly  |     Yes     |     Yes     |      No        |       No       |
| Internal  |     No      |     Yes     |      No        |       No       |
| Bridged   |     Yes     |     Yes     |      Yes       |       Yes      |
| NAT       |     No      |     No      |      Yes       |  Port forward  |
| NATNet    |     No      |     Yes     |      Yes       |  Port forward  |
+-----------+-------------+-------------+----------------+----------------+
```
