export SERVICE=vault
export CSR_NAME=vault-csr
export NAMESPACE=vault
export TEMP_DIR=/tmp/vault-tls

openssl genrsa -out ${TEMP_DIR}/vault.key 2048

cat <<EOF >${TEMP_DIR}/csr.conf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${SERVICE}
DNS.2 = ${SERVICE}.${NAMESPACE}
DNS.3 = ${SERVICE}.${NAMESPACE}.svc
DNS.4 = ${SERVICE}.${NAMESPACE}.svc.cluster.local
IP.1 = 127.0.0.1
EOF

openssl req -new -key ${TEMP_DIR}/vault.key \
  -subj "/O=system:nodes/CN=system:node:vault.${NAMESPACE}.svc" \
  -out ${TEMP_DIR}/server.csr \
  -config ${TEMP_DIR}/csr.conf

chmod 644 ${TEMP_DIR}/vault.key

cat <<EOF >${TEMP_DIR}/csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${CSR_NAME}
  namespace: ${NAMESPACE}
spec:
  groups:
    - system:authenticated
  request: $(cat ${TEMP_DIR}/server.csr | base64 | tr -d '\r\n')
  signerName: kubernetes.io/kubelet-serving
  usages:
    - digital signature
    - key encipherment
    - server auth
EOF

kubectl create -f ${TEMP_DIR}/csr.yaml
sleep 15
kubectl get csr ${CSR_NAME}
kubectl certificate approve ${CSR_NAME}
sleep 15

serverCert=$(kubectl get csr ${CSR_NAME} -o jsonpath='{.status.certificate}')
echo "${serverCert}" | openssl base64 -d -A -out ${TEMP_DIR}/vault.crt
kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 -d > ${TEMP_DIR}/ca.crt

kubectl create secret generic tls-server \
  --namespace ${NAMESPACE} \
  --from-file=vault.key=${TEMP_DIR}/vault.key \
  --from-file=vault.crt=${TEMP_DIR}/vault.crt
kubectl create secret generic tls-ca \
  --namespace ${NAMESPACE} \
  --from-file=ca.crt=${TEMP_DIR}/ca.crt

