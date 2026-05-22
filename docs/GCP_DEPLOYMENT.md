# Google Cloud Compute Engine Deployment

This is an alpha single-VM deployment. Do not run these commands until CI is green and the team
agrees to deploy.

Set variables locally:

```bash
export PROJECT_ID="your-gcp-project"
export REGION="asia-southeast2"
export ZONE="asia-southeast2-a"
export VM_NAME="bidmart-alpha"
export STATIC_IP_NAME="bidmart-alpha-ip"
```

Reserve a static IP:

```bash
gcloud compute addresses create "$STATIC_IP_NAME" \
  --project "$PROJECT_ID" \
  --region "$REGION"

gcloud compute addresses describe "$STATIC_IP_NAME" \
  --project "$PROJECT_ID" \
  --region "$REGION" \
  --format "value(address)"
```

Create the VM:

```bash
gcloud compute instances create "$VM_NAME" \
  --project "$PROJECT_ID" \
  --zone "$ZONE" \
  --machine-type e2-standard-2 \
  --image-family ubuntu-2204-lts \
  --image-project ubuntu-os-cloud \
  --boot-disk-size 50GB \
  --address "$(gcloud compute addresses describe "$STATIC_IP_NAME" --project "$PROJECT_ID" --region "$REGION" --format 'value(address)')" \
  --tags bidmart-alpha,http-server,https-server
```

Open only HTTP/HTTPS:

```bash
gcloud compute firewall-rules create bidmart-alpha-http \
  --project "$PROJECT_ID" \
  --allow tcp:80 \
  --target-tags bidmart-alpha \
  --source-ranges 0.0.0.0/0

gcloud compute firewall-rules create bidmart-alpha-https \
  --project "$PROJECT_ID" \
  --allow tcp:443 \
  --target-tags bidmart-alpha \
  --source-ranges 0.0.0.0/0
```

SSH into the VM:

```bash
gcloud compute ssh "$VM_NAME" --project "$PROJECT_ID" --zone "$ZONE"
```

Install Docker and Compose plugin on the VM:

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl git
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"
```

Log out and back in so the Docker group applies.

Clone and start:

```bash
git clone --recurse-submodules https://github.com/advprog-2026-A10-project/kester.git
cd kester
cp .env.example .env
nano .env
docker compose --env-file .env build
docker compose --env-file .env up -d
docker compose ps
```

For normal alpha deployment with prebuilt GHCR images, use:

```bash
docker compose --env-file .env pull
docker compose --env-file .env up -d
docker compose ps
```

Set `IMAGE_TAG=latest` for the newest alpha image, or set it to a short git SHA from the `images`
GitHub Actions workflow to deploy/rollback a specific version.

If GHCR packages are private, the VM must authenticate before `docker compose pull`:

```bash
echo "$GHCR_READ_TOKEN" | docker login ghcr.io -u "<github-username>" --password-stdin
```

Use a token with the smallest practical scope, normally package read access only. Alternatively,
make the alpha GHCR packages public so the VM does not need a GitHub token. If neither is available,
the VM can still build from source with `docker compose --env-file .env build`, but that is slower
and less useful for rollback evidence.

Rollback:

```bash
nano .env
# set IMAGE_TAG to the previous known-good short SHA
docker compose --env-file .env pull
docker compose --env-file .env up -d
docker compose ps
```

Health checks:

```bash
curl -f https://api.auth.bidmart.bid/health
curl -f https://api.auth.bidmart.bid/ready
curl -f https://api.bidmart.bid/catalog
curl -f https://admin-api.bidmart.bid/health
curl -f https://ws.bidmart.bid/
```

Stop:

```bash
docker compose --env-file .env down
```

Do not delete the `postgres-data` volume unless you intentionally want to remove alpha data.
