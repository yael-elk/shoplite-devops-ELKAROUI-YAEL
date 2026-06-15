# Rapport d'incident — ShopLite

## Template

---

**Titre :** [titre court]  
**Date :** [date]  
**Durée :** [HH:MM à HH:MM]  
**Sévérité :** [P1 / P2 / P3]  
**Statut :** [Résolu / En cours]  
**Incident Manager :** [nom]

---

## Impact

- Service(s) affecté(s) : `[ex: GET /api/products]`
- Utilisateurs impactés : `[ex: 100% des utilisateurs frontend]`
- Description : `[ce que l'utilisateur voyait]`

## Timeline

| Heure | Action | Responsable | Résultat |
|---|---|---|---|
| HH:MM | Détection | QA | Test rouge |
| HH:MM | Analyse logs | DevOps | Cause identifiée |
| HH:MM | Décision rollback | PO + IM | Validé |
| HH:MM | Rollback exécuté | DevOps | API redémarrée |
| HH:MM | Smoke test | QA | Tests verts |
| HH:MM | Incident clos | Incident Manager | — |

## Cause racine

[Description technique de la cause]

## Correction appliquée

[Commandes ou actions réalisées]

```bash
# Exemple de commandes utilisées
sh scripts/rollback.sh v1.0.0
```

## Vérifications post-incident

- [ ] `curl /api/health` → status ok
- [ ] `curl /api/products` → données présentes
- [ ] Tests Jest verts
- [ ] Données PostgreSQL intactes

## Actions préventives

| Action | Responsable | Deadline |
|---|---|---|
| [action] | [qui] | [quand] |

---

## Incident contrôlé du TP

**Titre :** Route `/api/products` cassée volontairement  
**Date :** 2026-06-15  
**Durée :** ~20 minutes  
**Sévérité :** P2  
**Statut :** Résolu

### Impact

- Service affecté : `GET /api/products`
- Frontend : catalogue produits vide
- API health : toujours verte

### Cause racine

Modification volontaire dans `products.js` pour simuler un bug (ex: requête SQL invalide ou erreur 500).

### Correction

Rollback vers l'image Docker `v1.0.0` via `scripts/rollback.sh`.

### Vérifications

- [x] Tests Jest verts après rollback
- [x] Données PostgreSQL conservées (pas de `docker compose down -v`)
- [x] Smoke tests verts
