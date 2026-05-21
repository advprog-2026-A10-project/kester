# BidMart Alpha Architecture

This repository is an experimental alpha deployment wrapper for the BidMart services.
It targets one Google Cloud Compute Engine VM running Docker Compose.

## Integrated Sources

| Service | Repository | Branch | Commit |
| --- | --- | --- | --- |
| Auth backend | `advprog-2026-A10-project/bidmart-auth-be` | `develop` | `4a41d9432c562689193f01d5297c173d58ebe790` |
| Auth frontend | `advprog-2026-A10-project/bidmart-auth-fe` | `develop` | `eed18d8b20c751e84abe4af192f31e8f5d77eb80` |
| Core backend | `advprog-2026-A10-project/bidmart-core-be` | `develop` | `945c32eb7f1213d17c1bfda500adeda6137bac52` |
| Core frontend | `advprog-2026-A10-project/bidmart-core-fe` | `develop` | `393b949d4e20830d13cfdd0b724238c08c942886` |
| Admin backend | `advprog-2026-A10-project/bidmart-admin-be` | `develop` | `73c752ec0f6e5dbef891fe9c2dd77ef288f123ad` |

`bidmart-admin-fe` and `bidmart-bidding-ws` are not packaged in this alpha because a `develop`
branch was not available during discovery. This avoids violating the develop-only source rule.

## Runtime Shape

```text
Porkbun DNS
  -> Google VM static external IP
  -> Caddy container on ports 80/443
  -> Docker internal network
     -> core-fe:3000
     -> auth-fe:3000
     -> auth-be:8080
     -> core-be:8081
     -> admin-be:8082
     -> postgres:5432
```

Only ports `80` and `443` should be public. Postgres and backend ports stay private on the
Docker network.

## Alpha Limitations

- Database is a Compose-managed Postgres container on the same VM.
- Core bidding realtime websocket is configured through `PUBLIC_BIDDING_WS_URL`, but the separate
  `bidmart-bidding-ws` repo is not included because it has no `develop` branch.
- Admin frontend is not included because `bidmart-admin-fe` has no `develop` branch.
- This repo is for alpha testing, not production hardening.

