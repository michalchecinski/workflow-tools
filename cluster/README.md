# Dedicated Local Development Cluster

## Network Configuration

### main
Setup the network interfaces
```
# /etc/netplan/00-install*
network:
  ethernets:
    enp3s0:  # Internet interface (directly off router)
      dhcp4: true
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 192.168.1.1
      routes: 
        - to: 192.168.1.0/24
          via: 192.168.1.1
          table: 102
      routing-policy:
        - from: 192.168.1.0/24
          table: 102
    enp4s0:  # Cluster Switch (creating gateway)
      dhcp4: false
      addresses: 
        - 10.0.0.1/24
      nameservers:
        addresses:
          - 192.168.1.1
      routes:
        - to: 10.0.0.0/24
          via: 10.0.0.1
          table: 101
      routing-policy:
        - from: 10.0.0.0/24
          table: 101
  version: 2
```

Set up the NAT Routing
- `update-alternatives --set iptables /usr/sbin/iptables-legacy`
- `update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy`
- `echo 1 > /proc/sys/net/ipv4/ip_forward`
- `sysctl net.ipv4.ip_forward  # Should show value of 1`
- `iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE --random`
- `iptables -A FORWARD -i enp4s0 -o enp3s0 -j ACCEPT`
- `iptables -A FORWARD -i enp3s0 -o enp4s0 -m conntrack --ctstate="RELATED,ESTABLISHED" -j ACCEPT`
- `apt install iptables-persistent  # This should automatically save the iptables, but if not...`
- `iptables-save > /etc/iptables/rules.v4`

Resources: https://dev.to/mikeyglitz/building-the-cluster-revised-edition-2k5l



### worker{n}
```
# /etc/netplan/00-install*
network:
  ethernets:
    eno1:
      addresses:
        - 10.0.0.{n+1}/24  # set static IP address
      gateway4: 10.0.0.1
      nameservers:
        addresses:
          - 192.168.1.1  # router IP address to utilize built-in DNS. Could also be 8.8.8.8, etc.
      dhcp4: no
  version: 2
```
