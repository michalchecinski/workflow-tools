# K8s Cluster Setup

## NFS Storage Class Provisioner
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.0.109 \
    --set nfs.path=/mnt/nfs4
```

Usage:
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
  annotations:
    nfs.io/storage-path: "test-path" # not required, depending on whether this annotation was shown in the storage class description
spec:
  storageClassName: managed-nfs-storage
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
```
