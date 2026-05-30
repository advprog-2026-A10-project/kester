# Environment Variables

Copy `.env.example` to `.env` on the Google Cloud VM. Do not commit `.env`.

| Name | Example | Used by | Secret | Change for real deploy |
| --- | --- | --- | --- | --- |
| `APP_HOST` | `bidmart.bid` | Caddy | No | Yes |
| `AUTH_HOST` | `auth.bidmart.bid` | Caddy/Auth FE | No | Yes |
| `AUTH_API_HOST` | `api.auth.bidmart.bid` | Caddy | No | Yes |
| `CORE_API_HOST` | `api.bidmart.bid` | Caddy | No | Yes |
| `ADMIN_API_HOST` | `admin-api.bidmart.bid` | Caddy | No | Yes |
| `ADMIN_HOST` | `admin.bidmart.bid` | Caddy/Admin FE | No | Yes |
| `WS_HOST` | `ws.bidmart.bid` | Caddy/Bidding WS | No | Yes |
| `PUBLIC_APP_URL` | `https://bidmart.bid` | FE build/Auth links | No | Yes |
| `PUBLIC_AUTH_URL` | `https://auth.bidmart.bid` | Core FE | No | Yes |
| `PUBLIC_AUTH_API_URL` | `https://api.auth.bidmart.bid` | Auth FE build/Core FE session validation | No | Yes |
| `PUBLIC_CORE_API_URL` | `https://api.bidmart.bid` | Core FE build | No | Yes |
| `PUBLIC_ADMIN_API_URL` | `https://admin-api.bidmart.bid` | Admin FE build | No | Yes |
| `PUBLIC_BIDDING_WS_URL` | `wss://ws.bidmart.bid` | Core FE build | No | Yes |
| `POSTGRES_USER` | `bidmart` | Postgres | No | Optional |
| `POSTGRES_PASSWORD` | `CHANGE_ME...` | Postgres/apps | Yes | Yes |
| `AUTH_DATABASE_URL` | `postgres://.../bidmart_auth` | Auth BE | Yes | Yes |
| `CORE_DATABASE_URL` | `postgres://.../bidmart_core` | Core/Admin BE | Yes | Yes |
| `APP_ENV` | `alpha` | Auth BE | No | Use `production` only when fully ready |
| `APP_AUTH_JWT_SECRET` | 32+ byte string | Auth BE | Yes | Yes |
| `APP_RESEND_API_KEY` | `re_...` | Auth BE | Yes | Yes |
| `APP_RESEND_FROM_EMAIL` | `BidMart <no-reply@auth.bidmart.bid>` | Auth BE | No | Yes |
| `APP_VERIFY_EMAIL_URL_BASE` | `https://auth.bidmart.bid/auth/verify-email?token=` | Auth BE | No | Yes |
| `APP_PASSWORD_RESET_URL_BASE` | `https://auth.bidmart.bid/auth/reset-password?token=` | Auth BE | No | Yes |
| `APP_CORS_ALLOWED_ORIGINS` | `https://bidmart.bid,https://auth.bidmart.bid` | Auth BE | No | Yes |
| `APP_AUTH_SESSION_COOKIE_SECURE` | `true` | Auth BE | No | Yes for HTTPS |
| `APP_AUTH_SESSION_COOKIE_DOMAIN` | `.bidmart.bid` | Auth BE | No | Yes when Auth FE and Auth BE use sibling subdomains |
| `APP_AUTO_MIGRATE_ON_STARTUP` | `true` | Core BE | No | Alpha yes; prod prefer explicit migration |
| `WS_POLL_INTERVAL_MS` | `2000` | Bidding WS | No | Optional |
| `WS_HEARTBEAT_MS` | `30000` | Bidding WS | No | Optional |

Generate a JWT secret:

```bash
openssl rand -base64 32
```

Store real secrets only on the VM `.env` file or in GitHub/Google secret stores.
