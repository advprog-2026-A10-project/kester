#!/usr/bin/env bash
set -euo pipefail

curl --fail --show-error --silent http://127.0.0.1:18080/health
curl --fail --show-error --silent http://127.0.0.1:18080/ready
curl --fail --show-error --silent http://127.0.0.1:18081/health
curl --fail --show-error --silent http://127.0.0.1:18081/ready
curl --fail --show-error --silent http://127.0.0.1:18082/health
curl --fail --show-error --silent http://127.0.0.1:18082/ready
curl --fail --show-error --silent http://127.0.0.1:13000 >/dev/null
curl --fail --show-error --silent http://127.0.0.1:13001 >/dev/null
