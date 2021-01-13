# Dedicated Local Development Cluster - Ansible

After manually installing Ubunut Server 20.04 on each node and Docker on the
main node, Ansible is used for the rest of the configuration.

Ansible is installed in the root python evironment: `pip install ansible`

A Root SSH key has been generated and deployed to each machine

#### Run
While being root in the `**/ansible/src`:

`ansible -i hosts cluster -m ping`


#### K8s

To get the token:
```
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
```
