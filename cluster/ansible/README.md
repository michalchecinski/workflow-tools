# Dedicated Local Development Cluster - Ansible

After manually installing Ubunut Server 20.04 on each node and Docker on the
main node, Ansible is used for the rest of the configuration.

Ansible is installed in the root python evironment: `pip install ansible`

A Root SSH key has been generated and deployed to each machine

## Run
While being root in the `**/ansible/src`:

### ping test
`ansible -i hosts nodes -m ping`

### Cluster OS update
This is a safe cluster OS update. It happens serially. If a reboot is necessary,
each node is drained of the k8s pods. It also checks for any ongoing work in a 
`tmux` session and prevents a reboot if that is the case (for the user: `joseph`)

`asnible-playbook -i hosts -e "targets=nodes" playbooks/cluster/update-os.yaml`


#### K8s

To get the token:
```
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
```
