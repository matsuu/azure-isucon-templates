#!/bin/sh

set -e

RESOURCE_GROUP="pixiv-isucon2016"
LOCATION="japanwest"
SSH_PUBLIC_KEY=`cat ~/.ssh/id_rsa.pub`
VM_SIZE="Standard_F2s"

# azure login
azure group create ${RESOURCE_GROUP} ${LOCATION}
azure group deployment create -f azuredeploy.json -p "{\"sshPublicKey\":{\"value\":\"${SSH_PUBLIC_KEY}\"},\"vmSize\":{\"value\":\"${VM_SIZE}\"}}" -g ${RESOURCE_GROUP}
