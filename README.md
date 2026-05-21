# BidMart Kester Alpha Deployment

Experimental deployment wrapper for `advprog-2026-A10-project`.

This repo packages the available `staging` branches into a one-VM Docker Compose stack for
alpha testing on Google Cloud Compute Engine. It does not deploy anything by itself.

## Included Services

- `bidmart-auth-be` from `staging`
- `bidmart-auth-fe` from `staging`
- `bidmart-core-be` from `staging`
- `bidmart-core-fe` from `staging`
- `bidmart-admin-be` from `staging`
- `bidmart-admin-fe` from `staging`
- `bidmart-bidding-ws` from `staging`
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
docker compose --env-file .env build
docker compose --env-file .env up -d
```

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
