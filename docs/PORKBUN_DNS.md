# Porkbun DNS

Use the static external IP reserved in Google Cloud.

Create these `A` records:

| Type | Host | Value |
| --- | --- | --- |
| `A` | `@` | `<GCP_STATIC_EXTERNAL_IP>` |
| `A` | `auth` | `<GCP_STATIC_EXTERNAL_IP>` |
| `A` | `api.auth` | `<GCP_STATIC_EXTERNAL_IP>` |
| `A` | `api` | `<GCP_STATIC_EXTERNAL_IP>` |
| `A` | `admin-api` | `<GCP_STATIC_EXTERNAL_IP>` |

Optional future records:

| Type | Host | Value | Notes |
| --- | --- | --- | --- |
| `A` | `admin` | `<GCP_STATIC_EXTERNAL_IP>` | Only after Admin FE has a `develop` deployment. |
| `A` | `ws` | `<GCP_STATIC_EXTERNAL_IP>` | Only after bidding websocket is packaged from `develop`. |
| `A` | `docs` | `<docs hosting IP or CNAME target>` | Use for Cloud Storage/static docs later. |

Public ports:

- `80/tcp`: Caddy HTTP and certificate redirect.
- `443/tcp`: Caddy HTTPS.

Keep these internal only:

- Postgres `5432`
- Auth BE `8080`
- Core BE `8081`
- Admin BE `8082`
- Auth FE `3000`
- Core FE `3000`

