# Run

```
docker run --rm -d \
  -p 8087:8087 \
  -e BW_HOST=0.0.0.0 \
  --env-file .env \
  --name bw-cli \
  registry.k8s.lan/bw-cli:0.1.0
```
