# BidMart Kester Alpha Deployment

Experimental deployment wrapper for `advprog-2026-A10-project`.

This repo packages the available `develop` branches into a one-VM Docker Compose stack for
alpha testing on Google Cloud Compute Engine. Services without a `develop` branch currently use
the latest available integration branch.

## Included Services

- `bidmart-auth-be` from `develop`
- `bidmart-auth-fe` from `develop`
- `bidmart-core-be` from `develop`
- `bidmart-core-fe` from `develop`
- `bidmart-admin-be` from `develop`
- `bidmart-admin-fe` from `staging` because no `develop` branch exists yet
- `bidmart-bidding-ws` from `staging` because no `develop` branch exists yet
- Postgres 16
- Caddy reverse proxy

## Local Source Update

```bash
git submodule update --init --recursive
./scripts/update-sources.sh
```

## Alpha VM Start

On the Google Cloud VM:

```bash
cp .env.example .env
# edit .env and replace secrets/domains
docker compose --env-file .env pull
docker compose --env-file .env up -d
```

To build directly on the VM instead of using GHCR images:

```bash
docker compose --env-file .env build
docker compose --env-file .env up -d
```

## Image Versioning and Rollback

GitHub Actions publishes service images to GitHub Container Registry with two tags:

- `latest` for the newest alpha build from `main`
- the short git SHA for a pinned rollback target

The VM reads `IMAGE_TAG` from `.env`. To deploy a pinned version:

```bash
IMAGE_TAG=0123456
docker compose --env-file .env pull
docker compose --env-file .env up -d
```

To roll back, change `IMAGE_TAG` to the previous known-good SHA, then run the same `pull` and `up -d` commands.

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Environment variables](docs/ENVIRONMENT.md)
- [Google Cloud deployment](docs/GCP_DEPLOYMENT.md)
- [Porkbun DNS](docs/PORKBUN_DNS.md)

## Safety

- No real secrets are committed.
- Only ports 80 and 443 should be public on the VM.
- Database and backend ports stay on the Docker network.
- Docker build/test validation runs in GitHub Actions.
