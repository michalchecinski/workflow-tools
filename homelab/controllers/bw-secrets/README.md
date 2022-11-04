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
kubectl create namespace hello
kubectl -n hello apply -k .
kubectl -n hello apply -f hello.yaml
```
