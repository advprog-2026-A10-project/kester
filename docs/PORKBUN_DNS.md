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
| `A` | `admin` | `<GCP_STATIC_EXTERNAL_IP>` |
| `A` | `ws` | `<GCP_STATIC_EXTERNAL_IP>` |

Public ports:

- `80/tcp`: Caddy HTTP and certificate redirect.
- `443/tcp`: Caddy HTTPS.

Keep these internal only:

- Postgres `5432`
- Auth BE `8080`
- Core BE `8081`
- Admin BE `8082`
- Bidding WS `8080`
- Auth FE `3000`
- Core FE `3000`
- Admin FE `3000`
