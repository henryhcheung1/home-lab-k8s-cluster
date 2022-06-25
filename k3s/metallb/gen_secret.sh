#!/bin/bash
random="$(openssl rand -base64 128 | tr -d '\n')"

cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: memberlist
  namespace: metallb-system
type: Opaque
data:
  secretkey: $random
EOF
