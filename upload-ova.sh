#!/bin/bash

set -eu

ova_path="$1"

# required
: "${GOVC_URL:?}"
: "${GOVC_USERNAME:?}"
: "${GOVC_PASSWORD:?}"
: "${GOVC_FOLDER:?}"
: "${GOVC_DATACENTER:?}"
: "${GOVC_DATASTORE:?}"
: "${GOVC_NETWORK:?}"

# optional
: "${TEMPLATE_NAME:=ops-mgr-tmpl}"
: "${GOVC_INSECURE:=true}"
: "${GOVC_RESOURCE_POOL:=}"

GOVC_HOST="" govc import.ova \
    -name="${TEMPLATE_NAME}" \
    -options=<(echo "{\"NetworkMapping\": [{\"Name\": \"Network 1\", \"Network\": \"${GOVC_NETWORK}\"}]}") \
    "${ova_path}"
