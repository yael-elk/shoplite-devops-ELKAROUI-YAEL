# Matrice RACI — ShopLite

## Rôles

| Rôle | Membre(s) |
|---|---|
| Product Owner (PO) | ELKAROUI Yael |
| Développeur API | ELKAROUI Yael |
| Développeur Frontend | ELKAROUI Yael |
| DevOps / Release Manager | ELKAROUI Yael |
| DBA / Référent données | ELKAROUI Yael |
| QA / Testeur | ELKAROUI Yael |
| Incident Manager | ELKAROUI Yael |

## Matrice

| Activité | PO | API | Frontend | DevOps | DBA | QA | IM |
|---|---|---|---|---|---|---|---|
| Créer la version stable Git | C | R | R | A | I | I | I |
| Mettre en place Docker Compose | I | C | C | R/A | I | I | I |
| Configurer la CI/CD | I | C | C | R/A | I | C | I |
| Ajouter le test `/api/products` | I | R | I | C | I | A | I |
| Sauvegarder PostgreSQL | I | I | I | C | R/A | I | I |
| Provoquer l'incident contrôlé | C | R | I | A | I | I | I |
| Diagnostiquer l'incident | C | R | C | R | C | R | A |
| Décider le rollback | A | C | C | C | C | C | R |
| Exécuter le rollback | I | I | I | R/A | C | I | I |
| Vérifier les données après rollback | I | I | I | I | R/A | C | I |
| Valider les tests après rollback | I | C | C | C | I | R/A | I |
| Rédiger le rapport d'incident | I | C | C | C | C | C | R/A |

**R** = Responsible (réalise) | **A** = Accountable (valide) | **C** = Consulted | **I** = Informed
