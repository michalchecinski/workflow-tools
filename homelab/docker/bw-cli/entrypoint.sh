
exp() {
    echo "[!] $1"
    exit 1
}

bw_auth() {
  bw login --apikey
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
}

if [ -z "$BW_CLIENTID" ]; then
    exp "BW_CLIENTID is required"
fi
if [ -z "$BW_CLIENTSECRET" ]; then
    exp "BW_CLIENTSECRET is required"
fi
if [ -z "$BW_PASSWORD" ]; then
    exp "BW_PASSWORD is required"
fi

if [ "$BW_HOST" ]; then
  HOST=$BW_HOST
fi

echo "-----Settings-----"
echo "HOST=$HOST"
echo "------------------"

bw_auth
bw serve --hostname $HOST
