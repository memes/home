#! /bin/sh
#
START_TIMESTAMP="${START_TIMESTAMP:-$(date -Iseconds -v -1H)}"
END_TIMESTAMP="${END_TIMESTAMP:-$(date -Iseconds)}"
PROJECT_ID="${PROJECT_ID:-$(gcloud config get project)}"

gcloud logging read \
        --project "${PROJECT_ID}" \
        --format json \
        "logName:projects/${PROJECT_ID}/logs/cloudaudit.googleapis.com ${PRINCIPAL:+"AND protoPayload.authenticationInfo.principalEmail=\"${PRINCIPAL}\""} AND timestamp>=\"${START_TIMESTAMP}\" ${END_TIMESTAMP:+"AND timestamp<=\"${END_TIMESTAMP}\""}" | \
    jq 'include "gcp/audit_log"; gcp_audit_log_resources'
