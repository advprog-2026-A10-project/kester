#!/usr/bin/env bash
set -euo pipefail

expect_http_response() {
  local url="$1"
  local status
  status="$(curl --show-error --silent --output /dev/null --write-out "%{http_code}" "$url")"
  if [ "$status" = "000" ] || [ "$status" -ge 500 ]; then
    echo "Expected a non-5xx HTTP response from $url, got $status" >&2
    return 1
  fi
}

curl --fail --show-error --silent http://127.0.0.1:18080/health
curl --fail --show-error --silent http://127.0.0.1:18080/ready
expect_http_response http://127.0.0.1:18081/catalog
curl --fail --show-error --silent http://127.0.0.1:18082/health
curl --fail --show-error --silent http://127.0.0.1:18082/ready
curl --fail --show-error --silent http://127.0.0.1:13000 >/dev/null
curl --fail --show-error --silent http://127.0.0.1:13001 >/dev/null
