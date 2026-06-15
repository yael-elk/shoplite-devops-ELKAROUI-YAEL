# Changelog

## [v1.1.0] - 2026-06-15

### Ajouté
- Route `/health/ready` pour la readiness probe
- `request_id` propagé dans tous les logs
- Sanitization des données sensibles dans les logs
- Tests produits (`api/tests/products.test.js`)
- Script `smoke-test.sh` avec retry
- Docker Compose : resource limits CPU/RAM, log rotation
- CI : matrix build Node 20/22, Trivy scan, artefacts coverage
- CD : deploy staging automatique sur push develop

### Modifié
- `health.js` : ajout de `version`, `environment`, `uptime_seconds`
- `logger.js` : logs JSON structurés avec niveaux INFO/WARN/ERROR
- `app.js` : version et environnement exposés sur la route `/`
- `Dockerfile` API : multi-stage build, labels OCI
- `docker-compose.yml` : env_file, volumes backup, log rotation

## [v1.0.0] - 2026-06-15

### Ajouté
- Code de base ShopLite (API Node.js + Frontend + PostgreSQL)
- Dockerfile API et frontend
- `docker-compose.yml` avec proxy Nginx
- `.github/workflows/ci.yml` et `cd.yml` (squelettes)
- Scripts `backup.sh`, `rollback.sh` (squelettes)
