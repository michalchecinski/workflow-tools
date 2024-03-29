# Prereqs

- ArgoCD installation and set up
- Cert Manager set up with a ClusterIssuer


# Install with ArgoCD

## Standalone mode
export VAULT_ADDR="https://vault.k8s.lan"
vault operator init

# Save unseal keys and root token somewhere safe

vault operator unseal  # x3

vault login


## HA with Raft

If I'm going to store all of the unseal keys in the same place, it doesn't make sense to make myself work extra hard to
unseal the nodes

```
kubectl exec -ti -n vault vault-0 -- vault operator init --key-threshold=1 --key-shares=1
kubectl exec -ti -n vault vault-0 -- vault operator unseal
kubectl exec -ti -n vault vault-1 -- vault operator unseal
kubectl exec -ti -n vault vault-2 -- vault operator unseal
```

### :Warning: Note: Issues 

- TLS isn't really working. I haven't created the tls secrets because there is a chicken/egg problem that I
need to figure out. If I'm going to be storing certs as k8s secrets, I can't automate the installation of vault with
argocd...
- The issue continues with a port forward directly to vault-0 responding with a `http: server gave HTTP response to HTTPS
client`. Even with TLS disabled, this is the case.
- Spent forever trying to get the tls certs set up. The cluster is now failing raft join (it didn't get this far
  previously) with this message. `dial tcp: lookup vault-1.vault-internal on 10.152.183.10:53: no such host"`. And the
  client is still having the above HTTP and HTTPS mismatch
- After many more hours, I have an HA cluster talking to eachother. However, I'm now running into an issue with the
  local vault: `x509: cannot validate certificate for 127.0.0.1` when using port forwarding to the `vault-active`
  service. I'm guessing that I'll have to load the CA cert into my local machine. However, because this is the CA from
  the `local-ca-issuer`, I should already have that one loaded...I guess this is because the cert isn't for `127.0.0.1`
- I fixed the ingress (by enabling it...) and then fixed the name of the secret. The local vault is now hitting the
  correct api, but I'm now getting `Client sent and HTTP request to an HTTPS server`. Not sure what that's abbout.
  `VAULT_ADDR` is set to `https://vault.k8s.lan` and the ingress defaults to TLS

# Backups
An NFS store has been set up specifically for backups. This volume is set to retain in the NFS provider. The volume will
not be remounted if Vault is destroyed and recreated; however, the backups will be retained on the NFS server for manual
recovery in the case of a disaster.

This is run with a CronJob like found [here](https://michaellin.me/backup-vault-with-raft-storage-on-kubernetes/) since
automated backups seem to be an Enterprise feature

# DR
[Follow Vault's Standard Procedure for
Restoring](https://learn.hashicorp.com/tutorials/vault/sop-restore?in=vault/standard-procedures)

