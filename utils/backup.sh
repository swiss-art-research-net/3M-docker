#!/bin/bash

set -e

source "$(dirname "${BASH_SOURCE[0]}")/../.env"

BACKUP_DATE=$(date +%Y-%m-%d_%H-%M)
BACKUP_BASE_PATH=temp

mkdir -p ${BACKUP_BASE_PATH}

for i in $(seq 1 50); do printf "="; done
echo ""
echo "[I] Starting backup on ${BACKUP_DATE}"

BIND_BACKUP=${BACKUP_BASE_PATH}/binds_${BACKUP_DATE}.tar.gz
tar -C ${BACKUP_PATH} -czf ${BIND_BACKUP} .

echo "[I] Uploading backup"
aws s3 cp "${BIND_BACKUP}" "s3://${AWS_BUCKET}" --endpoint-url "${AWS_ENDPOINT}"

rm "${BIND_BACKUP}"

echo "[I] Finished backup at $(date +%Y-%m-%d_%H-%M)"
for i in $(seq 1 3); do printf "\n"; done

exit 0
