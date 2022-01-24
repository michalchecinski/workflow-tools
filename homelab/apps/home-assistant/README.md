# Personal Home Assistant Helm Chart

I needed a personal helm chart so that ArgoCD could handle it for me with the non-default values.


## Secrets

There are a couple of secrets we need for this chart. Secrets are stored safely in Git via `Sealed Secrets`. Here's the
template:

```
apiVersion: v1
kind: Secret
metadata:
  name: home-assistant-secrets
type: Opaque
data:
  # You can include additional key value pairs as you do with Opaque Secrets
  postgresql-password: REPLACE
  postgresql-postgres-password: REPLACE
```
