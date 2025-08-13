#!/usr/bin/env bash
set -euo pipefail

# ----- image + tags (force lowercase) -----
RAW_IMAGE="ghcr.io/${GITHUB_REPOSITORY}/app"
IMAGE="$(echo "$RAW_IMAGE" | tr '[:upper:]' '[:lower:]')"

TAG_SHA="${GIT_COMMIT:-${GITHUB_SHA:-latest}}"
TAG_REF="$(echo "${GITHUB_REF_NAME:-latest}" | tr '[:upper:]' '[:lower:]')"

# ----- Dockerfile + context from args -----
DF="${1:-Dockerfile}"
CTX="${2:-.}"

echo "Building ${IMAGE}:${TAG_SHA}"
echo "Dockerfile: ${DF}"
echo "Context:    ${CTX}"

docker build -f "$DF" -t "${IMAGE}:${TAG_SHA}" "$CTX"
docker tag "${IMAGE}:${TAG_SHA}" "${IMAGE}:${TAG_REF}"
