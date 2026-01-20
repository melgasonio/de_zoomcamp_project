#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

NO_CACHE=0
if [[ "${1:-}" == "--no-cache" ]]; then NO_CACHE=1; fi

DOCKER_BUILD_OPTS=()
if [[ "$NO_CACHE" -eq 1 ]]; then DOCKER_BUILD_OPTS+=(--no-cache); fi

echo "Building Airflow image..."
docker build "${DOCKER_BUILD_OPTS[@]}" -f docker/Dockerfile.airflow -t de_zoomcamp_airflow:local .

echo "Building dbt image..."
docker build "${DOCKER_BUILD_OPTS[@]}" -f docker/Dockerfile.dbt -t de_zoomcamp_dbt:local .

echo "Builds finished. Listing images:"
docker images --format "{{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}" | grep de_zoomcamp || true