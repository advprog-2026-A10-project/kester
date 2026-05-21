FROM rust:1.88-bookworm AS builder
WORKDIR /app
COPY services/bidmart-auth-be .
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/bidmart-auth-be /usr/local/bin/app
COPY --from=builder /app/migrations ./migrations
# Staging currently contains unresolved conflict markers in the timestamped
# migration. Keep the source submodule untouched and use the clean schema copy
# that ships beside it so alpha containers can initialize a fresh database.
RUN cp ./migrations/schema.sql ./migrations/20260223191047_auth_schema.sql
EXPOSE 8080
ENV RUST_LOG=info
CMD ["/usr/local/bin/app"]
