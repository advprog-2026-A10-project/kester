# BidMart Alpha Architecture

This repository is an experimental alpha deployment wrapper for the BidMart services.
It targets one Google Cloud Compute Engine VM running Docker Compose.

## Integrated Sources

| Service | Repository | Branch | Commit |
| --- | --- | --- | --- |
| Auth backend | `advprog-2026-A10-project/bidmart-auth-be` | `staging` | `5b63c87b7bd748a5501085b5efcd6c349ef90f0e` |
| Auth frontend | `advprog-2026-A10-project/bidmart-auth-fe` | `staging` | `1bd4ecffcb489c917a6a56356f3afafa31a110d5` |
| Core backend | `advprog-2026-A10-project/bidmart-core-be` | `staging` | `d9fae8b1f0f303acf9ac49eeed62c5a6c01b6fca` |
| Core frontend | `advprog-2026-A10-project/bidmart-core-fe` | `staging` | `d742ead12f52cb7d4acd623985bcc3fd23a56566` |
| Admin backend | `advprog-2026-A10-project/bidmart-admin-be` | `staging` | `749d24e5d9bec8cbb25915d53ba9fbf87a3f967f` |
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

Backend containers use deployment-owned Dockerfiles under `deploy/dockerfiles/`. They mirror the
service Dockerfiles but build with Rust 1.88+, because the current dependency graph no longer
builds with the older Rust image pinned inside some source repositories.

## Alpha Limitations

- Database is a Compose-managed Postgres container on the same VM.
- This repo is for alpha testing, not production hardening.
