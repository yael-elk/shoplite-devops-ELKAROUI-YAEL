#!/bin/sh
set -eu

BASE_URL="${BASE_URL:-http://localhost:8080}"
RETRIES=5
WAIT=3

check() {
  URL="$1"
  LABEL="$2"
  i=0
  while [ $i -lt $RETRIES ]; do
    if curl -fsS "$URL" > /dev/null 2>&1; then
      echo "[OK] $LABEL ($URL)"
      return 0
    fi
    i=$((i+1))
    echo "  Tentative $i/$RETRIES échouée, attente ${WAIT}s..."
    sleep $WAIT
  done
  echo "[FAIL] $LABEL ($URL)" >&2
  return 1
}

echo "=== Smoke tests sur $BASE_URL ==="
check "$BASE_URL/api/health" "Health check"
check "$BASE_URL/api/health/ready" "Readiness check"
check "$BASE_URL/api/products" "Products API"
check "$BASE_URL/" "Frontend"
echo "=== Tous les smoke tests OK ==="
