#!/bin/sh
#
# Rotates a specific secret in multiple repositories matching the filter using gh and jq.
# Default values will rotate the RELEASE_PLEASE_TOKEN on repos the current user has access to where memes-bot is a
# collaborator.

SECRET_NAME="${SECRET_NAME:-RELEASE_PLEASE_TOKEN}"
LIMIT="${LIMIT:-200}"
MINIMUM_SECRET_AGE_SECS="${MINIMUM_SECRET_AGE_SECS:-3600}"
FILTER="${FILTER:-"map(select(.assignableUsers[]|.login==\"memes-bot\"))"}"

set -e

if [ -z "${SECRET_VALUE}" ]; then
    echo "$0: ERROR: SECRET_VALUE is empty" >&2
    exit 1
fi

gh repo list --no-archived --limit "${LIMIT}" --json 'nameWithOwner,assignableUsers' | \
    jq -r "${FILTER}|.[]|.nameWithOwner" | \
    while read -r repo; do
        if gh secret list --repo "${repo}" --json 'name,updatedAt' | \
            jq --exit-status "map(select(.name == \"${SECRET_NAME}\" and now - (.updatedAt|fromdateiso8601) > ${MINIMUM_SECRET_AGE_SECS})) | length > 0" >/dev/null; then
            echo "Updating ${SECRET_NAME} in ${repo}"
            gh secret set --repo "${repo}" --body "${SECRET_VALUE}" "${SECRET_NAME}"
        else
            echo "Skipping update of ${SECRET_NAME} in ${repo}, as it was updated recently"
        fi
    done
