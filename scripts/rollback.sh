#!/bin/sh
set -eu

TARGET_VERSION="${1:-}"

if [ -z "$TARGET_VERSION" ]; then
  echo "Usage: ./scripts/rollback.sh <version>"
  echo "Exemple: ./scripts/rollback.sh v1.0.0"
  echo ""
  echo "Images disponibles:"
  docker images shoplite-api --format "  {{.Tag}} ({{.Size}}) - {{.CreatedAt}}"
  exit 1
fi

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] === ROLLBACK VERS $TARGET_VERSION ==="

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Export des logs avant rollback..."
mkdir -p ./backups/logs
docker logs shoplite_api 2>&1 > "./backups/logs/api_before_rollback_$(date +%Y%m%d_%H%M%S).log" || true

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Vérification de l'image $TARGET_VERSION..."
if ! docker images shoplite-api --format "{{.Tag}}" | grep -q "^${TARGET_VERSION}$"; then
  echo "ERREUR : image shoplite-api:$TARGET_VERSION introuvable" >&2
  docker images shoplite-api
  exit 1
fi

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Backup PostgreSQL avant rollback..."
sh scripts/backup.sh

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Arrêt de l'API (sans toucher aux volumes)..."
docker compose stop api frontend proxy

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Redémarrage avec l'image $TARGET_VERSION..."
APP_VERSION=$TARGET_VERSION docker compose up -d --no-build api frontend proxy

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Attente du démarrage (15s)..."
sleep 15

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Smoke test post-rollback..."
BASE_URL=http://localhost:8080 sh scripts/smoke-test.sh

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] === ROLLBACK $TARGET_VERSION TERMINÉ AVEC SUCCÈS ==="
