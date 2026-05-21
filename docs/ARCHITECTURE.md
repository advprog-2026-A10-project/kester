# BidMart Alpha Architecture

This repository is an experimental alpha deployment wrapper for the BidMart services.
It targets one Google Cloud Compute Engine VM running Docker Compose.

## Integrated Sources

| Service | Repository | Branch | Commit |
| --- | --- | --- | --- |
| Auth backend | `advprog-2026-A10-project/bidmart-auth-be` | `develop` | `260a6f5ae729d13d289113f909ae9f2b0e5dafb4` |
| Auth frontend | `advprog-2026-A10-project/bidmart-auth-fe` | `develop` | `b3ad7a8063aab92cc5c2518ad3b7c767f74b5389` |
| Core backend | `advprog-2026-A10-project/bidmart-core-be` | `develop` | `4b5d152138cf0e5062b08ef8d277945bd37f8ccc` |
| Core frontend | `advprog-2026-A10-project/bidmart-core-fe` | `develop` | `7e1f3b645b921b1e766234a50fa2825de78e8e03` |
| Admin backend | `advprog-2026-A10-project/bidmart-admin-be` | `develop` | `73c752ec0f6e5dbef891fe9c2dd77ef288f123ad` |
| Admin frontend | `advprog-2026-A10-project/bidmart-admin-fe` | `staging` | `53cf195afdfe3962b40b38e9912c5141ccf28acf` |
| Bidding websocket | `advprog-2026-A10-project/bidmart-bidding-ws` | `staging` | `811d23e490dd7653f73e93a01b9e18abd48390a0` |

## Runtime Shape

```text
Porkbun DNS
  -> Google VM static external IP
  -> Caddy container on ports 80/443
  -> Docker internal network
     -> core-fe:3000
     -> auth-fe:3000
     -> admin-fe:3000
     -> auth-be:8080
     -> core-be:8081
     -> admin-be:8082
     -> bidding-ws:8080
     -> postgres:5432
```

Only ports `80` and `443` should be public. Postgres and backend ports stay private on the
Docker network.

Deployment-owned Dockerfiles under `deploy/dockerfiles/` build the source submodules directly.
The full Auth and Core implementations come from their `develop` branches; the old alpha route
overrides are not copied into those images.

`bidmart-admin-fe` and `bidmart-bidding-ws` do not currently expose `develop` branches, so this
alpha stack keeps their latest available integration branches until those teams publish `develop`.

## Alpha Limitations

- Database is a Compose-managed Postgres container on the same VM.
- This repo is for alpha testing, not production hardening.
