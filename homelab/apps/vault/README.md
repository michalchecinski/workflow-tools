# Initilization

```
# Install with ArgoCD

## Standalone mode
export VAULT_ADDR="https://vault.k8s.lan"
vault operator init

# Save unseal keys and root token somewhere safe

vault operator unseal  # x3

vault login


## HA with Raft
kubectl exec -ti -n vault vault-0 -- vault operator init
kubectl exec -ti -n vault vault-0 -- vault operator unseal
kubectl exec -ti -n vault vault-0 -- vault operator unseal
kubectl exec -ti -n vault vault-0 -- vault operator unseal

kubectl exec -ti -n vault vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl exec -ti -n vault vault-1 -- vault operator unseal
kubectl exec -ti -n vault vault-1 -- vault operator unseal
kubectl exec -ti -n vault vault-1 -- vault operator unseal

kubectl exec -ti -n vault vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
kubectl exec -ti -n vault vault-2 -- vault operator unseal
kubectl exec -ti -n vault vault-2 -- vault operator unseal
kubectl exec -ti -n vault vault-2 -- vault operator unseal
```

### :Warning: Note: Issues 

- TLS isn't really working. I haven't created the tls secrets because there is a chicken/egg problem that I
need to figure out. If I'm going to be storing certs as k8s secrets, I can't automate the installation of vault with
argocd...
- The issue continues with a port forward directly to vault-0 responding with a `http: server gave HTTP response to HTTPS
client`. Even with TLS disabled, this is the case.
- Looks like the auto_rejoin isn't working with or without TLS enabled

# Backups
An NFS store has been set up specifically for backups. This volume is set to retain in the NFS provider. The volume will
not be remounted if Vault is destroyed and recreated; however, the backups will be retained on the NFS server for manual
recovery in the case of a disaster.

This is run with a CronJob like found [here](https://michaellin.me/backup-vault-with-raft-storage-on-kubernetes/) since
automated backups seem to be an Enterprise feature

# DR
[Follow Vault's Standard Procedure for
Restoring](https://learn.hashicorp.com/tutorials/vault/sop-restore?in=vault/standard-procedures)

