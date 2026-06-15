# Métriques DORA — ShopLite

Les 4 indicateurs DORA (DevOps Research and Assessment) mesurent la performance d'une équipe DevOps.

## 1. Lead Time for Changes (Délai de livraison)

**Définition :** temps entre le premier commit et le déploiement en production.

| Mesure | Valeur TP |
|---|---|
| Commit feature → merge PR | ~30 min |
| Merge → CI verte | ~5 min |
| CI verte → staging | automatique |
| Staging → production (tag) | manuel (approbation) |
| **Total estimé** | **~1h** |

**Niveau Elite DORA :** < 1 jour ✅

## 2. Deployment Frequency (Fréquence de déploiement)

**Définition :** fréquence à laquelle le code est déployé en production.

| Environnement | Fréquence |
|---|---|
| Staging | À chaque push sur `develop` |
| Production | À chaque tag `v*` |

**Niveau TP :** plusieurs fois par jour (staging) → **Elite**

## 3. Mean Time to Restore (MTTR)

**Définition :** temps moyen pour restaurer le service après un incident.

| Étape | Durée estimée |
|---|---|
| Détection | < 2 min (smoke test) |
| Diagnostic | 5-10 min |
| Rollback | < 5 min (`rollback.sh`) |
| Vérification | 2 min |
| **MTTR total** | **~15 min** |

**Niveau Elite DORA :** < 1 heure ✅

## 4. Change Failure Rate (Taux d'échec des déploiements)

**Définition :** pourcentage de déploiements causant un incident.

| Déploiements | Incidents | Taux |
|---|---|---|
| 10 (TP simulé) | 1 (incident contrôlé) | 10% |

**Niveau Elite DORA :** < 5% (notre incident était volontaire ✅)

## Résumé

| Indicateur | Notre valeur | Niveau DORA |
|---|---|---|
| Lead Time | ~1h | Elite |
| Deployment Frequency | Plusieurs/jour | Elite |
| MTTR | ~15 min | Elite |
| Change Failure Rate | 10% (simulé) | High |
