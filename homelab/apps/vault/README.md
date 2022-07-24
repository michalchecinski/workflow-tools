# Initilization

```
# Install with ArgoCD
export VAULT_ADDR="https://vault.k8s.lan"
vault operator init

# Save unseal keys and root token somewhere safe

vault operator unseal  # x3

vault login
```

# Backups
An NFS store has been set up specifically for backups. This volume is set to retain in the NFS provider. The volume will
not be remounted if Vault is destroyed and recreated; however, the backups will be retained on the NFS server for manual
recovery in the case of a disaster.

# DR
[Follow Vault's Standard Procedure for
Restoring](https://learn.hashicorp.com/tutorials/vault/sop-restore?in=vault/standard-procedures)

