# ShopLite — TP Final DevOps

![CI](https://github.com/yael-elk/shoplite-devops-ELKAROUI-YAEL/actions/workflows/ci.yml/badge.svg)
![CD](https://github.com/yael-elk/shoplite-devops-ELKAROUI-YAEL/actions/workflows/cd.yml/badge.svg)

Mini application e-commerce industrialisée avec une chaîne DevOps complète.

## Stack

- **API** : Node.js 20 + Express + PostgreSQL
- **Frontend** : HTML/CSS/JS statique servi par Nginx
- **Infra** : Docker + Docker Compose
- **CI/CD** : GitHub Actions
- **Base de données** : PostgreSQL 16

## Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (inclut Docker Compose)
- Git

## Installation et lancement

```bash
# 1. Cloner le repo
git clone https://github.com/yael-elk/shoplite-devops-ELKAROUI-YAEL.git
cd shoplite-devops-ELKAROUI-YAEL/shoplite

# 2. Créer le fichier .env à partir de l'exemple
cp .env.example .env

# 3. Lancer l'application
docker compose up -d --build

# 4. Ouvrir dans le navigateur
open http://localhost:8080
```

## Tester l'API

```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/health/ready
curl http://localhost:8080/api/products
```

## Lancer les tests

```bash
cd api
npm ci
npm test
npm run test:coverage
```

## Lancer le linter

```bash
cd api
npm run lint
npm run format:check
```

## Environnements

| Environnement | Port | Commande |
|---|---|---|
| Dev (local) | 8080 | `docker compose up -d` |
| Staging (local) | 8081 | `docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d` |
| Production (simulée) | 8080 | `APP_VERSION=v1.0.0 docker compose up -d` |

## Scripts utiles

```bash
# Sauvegarder PostgreSQL
sh scripts/backup.sh

# Tester la restauration
sh scripts/restore-test.sh

# Rollback vers une version stable
sh scripts/rollback.sh v1.0.0

# Smoke tests
sh scripts/smoke-test.sh
```

## Commandes de diagnostic

```bash
docker compose ps
docker compose logs --tail=100 api
docker inspect shoplite_api
curl http://localhost:8080/api/health
```

## Architecture

Voir [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

## Changelog

Voir [CHANGELOG.md](CHANGELOG.md)

## Contribution

Voir [CONTRIBUTING.md](CONTRIBUTING.md)