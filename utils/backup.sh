#!/bin/bash

# ! NOTE ! 
# This script uses the AWS CLI to upload the backups to an S3 bucket.
# Make sure you have the AWS CLI installed (see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

set -e

source "$(dirname "${BASH_SOURCE[0]}")/../.env"

BACKUP_DATE=$(date +%Y-%m-%d_%H-%M)
BACKUP_BASE_PATH="$(dirname "${BASH_SOURCE[0]}")/temp"

mkdir -p ${BACKUP_BASE_PATH}

for i in $(seq 1 50); do printf "="; done
echo ""
echo "[I] Starting backup on ${BACKUP_DATE}"

BIND_BACKUP=${BACKUP_BASE_PATH}/binds_${BACKUP_DATE}.tar.gz
tar -C ${BACKUP_PATH} -czf ${BIND_BACKUP} .

echo "[I] Uploading backup"
aws s3 cp "${BIND_BACKUP}" "s3://${AWS_BUCKET}" --endpoint-url "${AWS_ENDPOINT}" --access-key "${AWS_ACCESS_KEY_ID}" --secret-key "${AWS_SECRET_ACCESS_KEY}"

rm "${BIND_BACKUP}"

echo "[I] Finished backup at $(date +%Y-%m-%d_%H-%M)"
for i in $(seq 1 3); do printf "\n"; done

# Delete backups older than 100 days
BACKUP_PREFIX="binds_"
BACKUP_DATE_FORMAT="+%Y-%m-%d_%H-%M"

# Get the current date
CURRENT_DATE=$(date ${BACKUP_DATE_FORMAT})

# Calculate the date threshold
BACKUP_THRESHOLD_DATE=$(date -d "-${BACKUP_DAYS_THRESHOLD} days" ${BACKUP_DATE_FORMAT})

# List all objects in the S3 bucket
BACKUP_OBJECTS=$(aws s3api list-objects --bucket "${AWS_BUCKET}" --endpoint-url "${AWS_ENDPOINT}" --access-key "${AWS_ACCESS_KEY_ID}" --secret-key "${AWS_SECRET_ACCESS_KEY}" --prefix "${BACKUP_PREFIX}" --query 'Contents[?LastModified<`'"${BACKUP_THRESHOLD_DATE}"'`].Key' --output text)

# Delete the backup objects
if [[ -n "${BACKUP_OBJECTS}" ]]; then
    echo "[I] Deleting backups older than ${BACKUP_DAYS_THRESHOLD} days"
    aws s3api delete-objects --bucket "${AWS_BUCKET}" --endpoint-url "${AWS_ENDPOINT}" --access-key "${AWS_ACCESS_KEY_ID}" --secret-key "${AWS_SECRET_ACCESS_KEY}" --delete "$(jq -n --arg objects "${BACKUP_OBJECTS}" '{Objects: ($objects | split("\n")[:-1] | map({Key: .}))}')"
else
    echo "[I] No backups found older than ${BACKUP_DAYS_THRESHOLD} days"
fi
exit 0
