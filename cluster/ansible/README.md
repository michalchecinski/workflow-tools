# Dedicated Local Development Cluster - Ansible

After manually installing Ubunut Server 20.04 on each node and Docker on the
main node, Ansible is used for the rest of the configuration.

Docker is used to make this configuration management environment very portable

## Usage

A Dockerfile is provided in the `workflow-tools/cluster/ansible` directory.

#### Build
From the `workflow-tools/cluster/ansible` directory:
`docker build -t ansible .` 

#### Run
`docker run -ti --rm -v ${PWD}/src:/etc/ansible/`

`$ ansible main_node -m ping -u joseph -k`
