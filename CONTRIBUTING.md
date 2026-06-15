# Contribuer à ShopLite

## Branches

| Branche | Rôle |
|---|---|
| `main` | Production — protégée, PR obligatoire |
| `develop` | Intégration — déclenche le déploiement staging |
| `feature/*` | Nouvelles fonctionnalités |
| `fix/*` | Corrections de bugs |
| `hotfix/*` | Corrections urgentes depuis `main` |

## Workflow

```bash
# Nouvelle feature
git checkout develop
git pull
git checkout -b feature/ma-feature

# ... travail ...

git add .
git commit -m "feat: description courte"
git push origin feature/ma-feature
# Ouvrir une PR vers develop
```

## Commits conventionnels

| Préfixe | Usage |
|---|---|
| `feat:` | Nouvelle fonctionnalité |
| `fix:` | Correction de bug |
| `docs:` | Documentation |
| `test:` | Tests |
| `ci:` | CI/CD |
| `chore:` | Maintenance |
| `refactor:` | Refactoring |

## Pull Request

Utiliser le template `.github/pull_request_template.md`.  
Une PR doit avoir : au moins 1 reviewer, la CI verte, et les tests qui passent.

## Hotfix

```bash
git checkout main
git checkout -b hotfix/description
# ... correction ...
git commit -m "fix: correction urgente"
# PR vers main ET develop
```
