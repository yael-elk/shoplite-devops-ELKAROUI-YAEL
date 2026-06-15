# Rapport d'incident — ShopLite

## Incident contrôlé du TP

**Titre :** Route `/api/products` cassée volontairement  
**Date :** 2026-06-15  
**Durée :** 10:00 à 10:14  
**Sévérité :** P2  
**Statut :** Résolu  
**Incident Manager :** ELKAROUI Yael  

## Impact

- Service affecté : `GET /api/products`
- Utilisateurs impactés : 100% des utilisateurs frontend (catalogue vide)
- Description : la route products retournait une erreur 500 car la table SQL n'existait pas

## Timeline

| Heure | Action | Responsable | Résultat |
|---|---|---|---|
| 10:00 | Backup PostgreSQL avant incident | DevOps | backups/shoplite_avant_incident.sql créé |
| 10:05 | Modification products.js (table "produits_cassees") | Dev API | Commit feature/incident-controle |
| 10:08 | Docker rebuild + curl /api/products | QA | {"error":"Internal server error"} confirmé |
| 10:13 | Rollback vers v1.0.0 via rollback.sh | DevOps | sh scripts/rollback.sh v1.0.0 |
| 10:14 | Smoke tests post-rollback | QA | Health ✅ Ready ✅ Products ✅ Frontend ✅ |
| 10:14 | Vérification données PostgreSQL | DBA | 3 produits présents, aucune perte |
| 10:14 | Incident clos | IM | Rollback v1.0.0 terminé avec succès |

## Cause racine

Modification volontaire de la requête SQL dans `api/src/routes/products.js` :  
table `products` remplacée par `produits_cassees` qui n'existe pas en base.

## Commandes utilisées

```bash
# Backup avant incident
docker exec shoplite_db pg_dump -U shoplite -d shoplite > backups/shoplite_avant_incident.sql

# Rollback
sh scripts/rollback.sh v1.0.0

# Vérification
curl http://localhost:8080/api/products
```

## Vérifications post-rollback

- [x] `curl /api/health` → status ok
- [x] `curl /api/products` → 3 produits présents
- [x] Smoke tests verts
- [x] Données PostgreSQL intactes (pas de docker compose down -v)

## Actions préventives

| Action | Responsable | Deadline |
|---|---|---|
| Ajouter test automatisé sur /api/products en CI | QA | Immédiat |
| Review obligatoire avant merge sur main | DevOps | Immédiat |
| Backup automatique avant chaque déploiement | DevOps | Immédiat |