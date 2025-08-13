#!/usr/bin/env bash
set -euo pipefail

RAW_IMAGE="ghcr.io/${GITHUB_REPOSITORY}/app"
IMAGE="$(echo "${RAW_IMAGE}" | tr '[:upper:]' '[:lower:]')"
TAG_SHA="${GIT_COMMIT:-${GITHUB_SHA:-latest}}"
TAG_REF="$(echo "${GITHUB_REF_NAME:-latest}" | tr '[:upper:]' '[:lower:]')"

echo "${docker_password}" | docker login ghcr.io -u "${docker_username}" --password-stdin

docker push "${IMAGE}:${TAG_SHA}"
docker push "${IMAGE}:${TAG_REF}"
