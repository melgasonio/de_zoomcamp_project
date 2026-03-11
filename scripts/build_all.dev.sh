#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

NO_CACHE=0
if [[ "${1:-}" == "--no-cache" ]]; then NO_CACHE=1; fi

DOCKER_BUILD_OPTS=()
if [[ "$NO_CACHE" -eq 1 ]]; then DOCKER_BUILD_OPTS+=(--no-cache); fi

echo "Building Airflow image for dev..."
docker build "${DOCKER_BUILD_OPTS[@]}" -f docker/dev/Dockerfile.airflow.dev -t de_zoomcamp_airflow:local .

echo "Building ingest image for dev..."
docker build "${DOCKER_BUILD_OPTS[@]}" -f dbt/dev/Dockerfile.ingest.dev -t de_zoomcamp_ingest:local .

echo "Building dbt image for dev..."
docker build "${DOCKER_BUILD_OPTS[@]}" -f docker/dev/Dockerfile.dbt.dev -t de_zoomcamp_dbt:local .

echo "Builds finished. Listing images:"
docker images --format "{{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}" | grep de_zoomcamp || true