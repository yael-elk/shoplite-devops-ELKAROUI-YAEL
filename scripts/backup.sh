#!/bin/sh
set -eu

CONTAINER="${DB_CONTAINER:-shoplite_db}"
DB_NAME="${POSTGRES_DB:-shoplite}"
DB_USER="${POSTGRES_USER:-shoplite}"
BACKUP_DIR="./backups"
RETENTION_DAYS=7
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/shoplite_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Démarrage du backup..."
docker exec "$CONTAINER" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
  echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Backup OK : $BACKUP_FILE ($SIZE)"
else
  echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] ERREUR : backup échoué" >&2
  exit 1
fi

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Nettoyage des backups de plus de $RETENTION_DAYS jours..."
find "$BACKUP_DIR" -name "shoplite_*.sql" -mtime +$RETENTION_DAYS -delete
REMAINING=$(find "$BACKUP_DIR" -name "shoplite_*.sql" | wc -l)
echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Backups restants : $REMAINING"
