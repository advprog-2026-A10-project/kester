# Releases and Rollback

The `images` GitHub Actions workflow publishes each service image to GHCR.

Version tags:

- Every push to `main` publishes `latest` and the short commit SHA.
- Every tag that starts with `v`, for example `v0.1.0-alpha.1`, publishes that version tag and creates a GitHub Release.

Normal alpha deployment:

```bash
git pull --rebase origin main
git submodule update --init --recursive
docker compose --env-file .env pull
docker compose --env-file .env up -d
docker compose ps
```

Deploy a specific version:

```bash
./scripts/deploy-version.sh v0.1.0-alpha.1
```

Rollback:

```bash
./scripts/deploy-version.sh <previous-version-or-short-sha>
```

The script only changes `IMAGE_TAG` in the VM `.env`, pulls images, and restarts the Compose stack. It does not delete data volumes.
