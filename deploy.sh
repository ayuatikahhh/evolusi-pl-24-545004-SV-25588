#!/usr/bin/env bash
set -e

echo "[1/7] php artisan down --retry=60"
echo "[2/7] git pull origin main"
echo "[3/7] composer install --no-dev --optimize-autoloader"
echo "[4/7] php artisan migrate --force"
echo "[5/7] php artisan config:cache && php artisan route:cache && php artisan view:cache"
echo "[6/7] php artisan queue:restart"
echo "[7/7] php artisan up"