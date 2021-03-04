#!/bin/bash

if [[ -n $1 ]]; then
    volume_name=$1
else
    echo "[!] Missing volume name"
    exit 1
fi

gluster volume create $volume_name replica 3 \
    k8s-node1:/export/gluster-lv/$volume_name \
    k8s-node2:/export/gluster-lv/$volume_name \
    k8s-node3:/export/gluster-lv/$volume_name


gluster volume start $volume_name
