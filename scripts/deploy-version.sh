#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "usage: ./scripts/deploy-version.sh <image-tag>" >&2
  exit 2
fi

image_tag="$1"
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
env_file="${repo_dir}/.env"

if [ ! -f "$env_file" ]; then
  echo ".env not found. Copy .env.example to .env and fill required values first." >&2
  exit 1
fi

if grep -q '^IMAGE_TAG=' "$env_file"; then
  sed -i "s/^IMAGE_TAG=.*/IMAGE_TAG=${image_tag}/" "$env_file"
else
  printf '\nIMAGE_TAG=%s\n' "$image_tag" >> "$env_file"
fi

cd "$repo_dir"
docker compose --env-file "$env_file" pull
docker compose --env-file "$env_file" up -d
docker compose ps
