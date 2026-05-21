#!/usr/bin/env bash
set -euo pipefail

curl_ok() {
  local name="$1"
  local url="$2"
  echo "Checking ${name}: ${url}"
  curl --fail --show-error --silent --retry 5 --retry-delay 2 --retry-all-errors "$url" >/dev/null
}

expect_http_response() {
  local name="$1"
  local url="$2"
  local status
  echo "Checking ${name}: ${url}"
  status="$(curl --show-error --silent --retry 5 --retry-delay 2 --retry-all-errors --output /dev/null --write-out "%{http_code}" "$url")"
  if [ "$status" = "000" ] || [ "$status" -ge 500 ]; then
    echo "Expected a non-5xx HTTP response from ${name} at $url, got $status" >&2
    return 1
  fi
}

curl_ok "auth-be health" http://127.0.0.1:18080/health
curl_ok "auth-be ready" http://127.0.0.1:18080/ready
expect_http_response "core-be catalog" http://127.0.0.1:18081/catalog
curl_ok "admin-be health" http://127.0.0.1:18082/health
curl_ok "admin-be ready" http://127.0.0.1:18082/ready
curl_ok "bidding-ws health" http://127.0.0.1:18083
curl_ok "auth-fe" http://127.0.0.1:13000
curl_ok "core-fe" http://127.0.0.1:13001
curl_ok "admin-fe" http://127.0.0.1:13002
