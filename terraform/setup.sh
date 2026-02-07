#!/bin/bash
# Exit on any error
set -e

echo "Starting setup script..."

# Wait for any background apt-get processes to finish
echo "Waiting for system locks to release..."
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do
    sleep 5
done
systemctl stop unattended-upgrades || true

# 1. Update system and install base dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y
apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    nginx \
    certbot \
    python3-certbot-nginx \
    ufw

# 2. Install Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 3. Configure Firewall (UFW)
ufw allow 'Nginx Full'
ufw allow OpenSSH
ufw --force enable

# 4. Set up Nginx Reverse Proxy for the Rails App
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name bootsoft.net www.bootsoft.net bootsoft.org www.bootsoft.org;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    location ^~ /.well-known/acme-challenge/ {
        root /var/www/html;
    }
}
EOF

systemctl restart nginx

# Wrap certbot in a check so it doesn't kill the whole script if DNS isn't ready
certbot --nginx \
  -d bootsoft.net -d www.bootsoft.net -d bootsoft.org -d www.bootsoft.org \
  --non-interactive \
  --agree-tos \
  --register-unsafely-without-email \
  --redirect || echo "Certbot failed - likely due to DNS not pointing here yet. Run manually later."

# 5. Optional: Authenticate Docker with Google Artifact Registry
# Note: The VM Service Account needs 'Artifact Registry Reader' permissions
gcloud auth configure-docker asia-northeast1-docker.pkg.dev --quiet