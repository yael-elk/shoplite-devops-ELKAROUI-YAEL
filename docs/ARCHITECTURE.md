# Architecture ShopLite

## Vue d'ensemble

```
Internet
   │
   ▼
┌──────────────┐
│  Nginx proxy  │  :8080 (dev) / :8081 (staging)
│  (reverse     │
│   proxy)      │
└──────┬───────┘
       │
  ┌────┴────┐
  │         │
  ▼         ▼
┌─────┐  ┌──────────┐
│Front│  │  API     │  :3000
│end  │  │ Node.js  │
│Nginx│  │ Express  │
└─────┘  └────┬─────┘
              │
              ▼
         ┌──────────┐
         │PostgreSQL│  :5432
         │   16     │
         └──────────┘
```

## Services Docker Compose

| Service | Image | Port interne | Rôle |
|---|---|---|---|
| `proxy` | nginx:1.27-alpine | 80 | Reverse proxy, point d'entrée |
| `frontend` | shoplite-frontend | 80 | Fichiers statiques |
| `api` | shoplite-api | 3000 | API REST Node.js |
| `db` | postgres:16-alpine | 5432 | Base de données |

## Réseau

Tous les services communiquent via le réseau Docker `shoplite_net`.  
Seul le proxy expose un port sur l'hôte.

## Volumes

| Volume | Contenu |
|---|---|
| `shoplite_pgdata` | Données PostgreSQL (persistant) |
| `./backups` | Dumps SQL horodatés |

## Endpoints API

| Route | Description |
|---|---|
| `GET /` | Infos API (version, env) |
| `GET /health` | Health check détaillé (API + DB) |
| `GET /health/ready` | Readiness probe |
| `GET /products` | Liste des produits |

## CI/CD

```
Push/PR
   │
   ▼
CI (ci.yml)
├── lint (ESLint + Prettier)
├── test (Jest, matrix Node 20/22, vraie DB)
├── audit (npm audit, Trivy)
└── build-docker
        │
        ▼ (push develop)
CD (cd.yml)
├── deploy-staging (port 8081)
│       └── smoke-test
│
└── deploy-production (tag v*)  ← approbation manuelle requise
        └── smoke-test
```

## Environnements

| Env | Port | Branch/Tag | Approbation |
|---|---|---|---|
| Dev | 8080 | toutes | automatique |
| Staging | 8081 | `develop` | automatique |
| Production | 8080 | `v*` | manuelle |

## En production réelle

Les logs iraient vers un système centralisé (ex: ELK Stack, Datadog, Loki).  
Les images seraient publiées sur un registry (Docker Hub, GHCR, ECR).  
PostgreSQL serait un service managé (RDS, Cloud SQL).
