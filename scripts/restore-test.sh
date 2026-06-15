#!/bin/sh
set -eu

CONTAINER="${DB_CONTAINER:-shoplite_db}"
DB_USER="${POSTGRES_USER:-shoplite}"
BACKUP_DIR="./backups"

LATEST=$(ls -t "$BACKUP_DIR"/shoplite_*.sql 2>/dev/null | head -1)

if [ -z "$LATEST" ]; then
  echo "ERREUR : aucun backup trouvé dans $BACKUP_DIR" >&2
  exit 1
fi

echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Test de restauration depuis : $LATEST"

TEST_DB="shoplite_restore_test"
docker exec "$CONTAINER" psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS $TEST_DB;"
docker exec "$CONTAINER" psql -U "$DB_USER" -c "CREATE DATABASE $TEST_DB;"
docker exec -i "$CONTAINER" psql -U "$DB_USER" -d "$TEST_DB" < "$LATEST"

COUNT=$(docker exec "$CONTAINER" psql -U "$DB_USER" -d "$TEST_DB" -tAc "SELECT COUNT(*) FROM products;")
echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Restauration OK - $COUNT produits trouvés"

docker exec "$CONTAINER" psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS $TEST_DB;"
echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] Base de test supprimée. Restauration validée."
