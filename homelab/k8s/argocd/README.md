# ArgoCD

## Installation
```
kubectl create namespace argocd
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.0.3/manifests/install.yaml
```

## Setup ingress
```
kubectl apply -n argocd -f argo-ingress.yaml
```
