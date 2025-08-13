#!/usr/bin/env bash
set -euo pipefail

# Example: push to GHCR
REGISTRY="ghcr.io"

# Compose a name (example) and force lowercase
RAW_IMAGE="ghcr.io/${GITHUB_REPOSITORY}/app"   # GITHUB_REPOSITORY is owner/RepoName
IMAGE="$(echo "${RAW_IMAGE}" | tr '[:upper:]' '[:lower:]')"

TAG_SHA="${GIT_COMMIT:-${GITHUB_SHA:-latest}}"
TAG_REF="$(echo "${GITHUB_REF_NAME:-latest}" | tr '[:upper:]' '[:lower:]')"

echo "Building ${IMAGE}:${TAG_SHA}"
docker build -t "${IMAGE}:${TAG_SHA}" .

# Optionally also tag with branch/ref
docker tag "${IMAGE}:${TAG_SHA}" "${IMAGE}:${TAG_REF}"

