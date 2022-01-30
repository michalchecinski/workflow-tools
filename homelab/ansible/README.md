# Dedicated Local Development Cluster - Ansible

After manually installing Ubunut Server 20.04 on each node and Docker on the
main node, Ansible is used for the rest of the configuration.

Ansible is installed in the root python evironment: `pip install ansible`

A Root SSH key has been generated and deployed to each machine

## Cluster Nodes
While being root in the `**/ansible/src`:

### ping test
`ansible -i hosts nodes -m ping`

### One-off commands
**ping:** `ansible -i hosts nas -a 'ping -c 1 www.google.com'`
**install microk8s:** `ansible -i hosts nodes -a 'snap install microk8s --classic'`
**start microk8s:** `ansible -i hosts nodes -a 'microk8s start'`
**stop microk8s:** `ansible -i hosts nodes -a 'microk8s stop'`

### OS update
This is a safe cluster OS update. It happens serially. If a reboot is necessary,
each node is drained of the k8s pods. It also checks for any ongoing work in a 
`tmux` session and prevents a reboot if that is the case (for the user: `joseph`)

```
#############
#  homelab  #
#############
Update cluster: homelab update homelab
Update just nodes: homelab update nodes
Update just nas: homelab update nas
Update single machine: homelab update k8s-node1

#############
#  Ansible  #
#############
Update cluster: ansible-playbook -i hosts -K -e "targets=homelab" playbooks/update-os.yml
Update just nodes: ansible-playbook -i hosts -K -e "targets=nodes" playbooks/update-os.yml
Update just nas: ansible-playbook -i hosts -K -e "targets=nas" playbooks/update-os.yml
Update single machine: ansible-playbook -i hosts -K -e "targets=k8s-node1" playbooks/update-os.yml
```

### Power down
This powers down the cluster

```
#############
#  homelab  #
#############
Power down cluster: homelab down homelab
Power down just nodes: homelab down nodes
Power down just nas: homelab down nas
Power down single machine: homelab down k8s-node1

#############
#  Ansible  #
#############
Power down cluster: asnible-playbook -i hosts -K -e "targets=cluster" playbooks/power-down.yml
Power down just nodes: asnible-playbook -i hosts -K -e "targets=nodes" playbooks/power-down.yml
Power down just nas: asnible-playbook -i hosts -K -e "targets=nas" playbooks/power-down.yml
```


## K8s

### Cluster Access
To get the token:
```
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
```

### Cluster Admin via Ansible
#### Requirements

- Ansible
  - `brew install ansible`
- Helm
  - `brew install helm`
- Kubernetes python module
  - `pip3 install kubernetes`
- Kubernetes Ansible Collection
  - `ansible-galaxy collection install -r requirements.yml`

#### How setup to test

1. Install [K3d](https://k3d.io/v5.2.1/)
2. Build a K8s cluster.
    -  `k3d cluster create test-ansible --image rancher/k3s:v1.20.7-k3s1`

### How to run

1. Validate the environment variables in `<env>-values.yml` or create a new file if needed.
2. Switch to the correct k8s cluster context
3. Run the `main-clusters.yml` playbook with Ansible, passing in the values file.
   1. `ansible-playbook playbooks/k8s-cluster-admin.yml -e "@values/nucs.yml"`
