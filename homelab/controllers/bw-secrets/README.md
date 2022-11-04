# Custom Hello Controller

## Prereqs

- kubectl
- access to a k8s cluster
- Bitwarden Account with an Api Key

```
# ===== Setup .env file =====
cp .env.example .env

# Fill out the .env without any quotes around the strings


# ===== Create the k8s resources =====
kubectl create namespace bw-secrets
kubectl create namespace ee-test
kubectl -n bw-secrets apply -k .
kubectl -n ee-test apply -f test.yaml
```
