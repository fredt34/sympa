# TODO.md - To-do pour le projet d'alias de listes Sympa

Ce document liste les tâches à accomplir pour implémenter la fonctionnalité d'alias de listes et soumettre une Pull Request de qualité.

## Phase 1 : Conception et plan d'exécution

- [ ]  Confirmer le design de la nouvelle table de base de données `list_alias`.
    -   Définir les colonnes (ex: `list_id`, `alias_name`).
- [ ]  Identifier les fichiers de code Perl à modifier dans `sympa.pl`.
- [ ]  Déterminer comment interagir avec le système d'alias du serveur (ex: `/etc/aliases`) et la commande `newaliases`.

## Phase 2 : Développement

- [ ]  **Création du script de migration de la base de données.**
    -   Écrire un script SQL pour créer la table `list_alias`.
    -   Tester le script sur une base de données de développement.
- [ ]  **Implémentation des nouvelles commandes dans `sympa.pl` :**
    -   [ ]  Ajouter le support des options `--add_alias`, `--add_alias_first`, et `--remove_alias`.
    -   [ ]  Écrire les fonctions Perl pour chaque commande.
    -   [ ]  S'assurer que les fonctions gèrent correctement la base de données et les alias système.
    -   [ ]  Gérer les cas d'erreur (liste non trouvée, alias déjà existant, etc.).
- [ ]  **Modification de la commande `rename_list` :**
    -   [ ]  Modifier le comportement de `sympa.pl --rename_list` pour qu'il appelle la nouvelle fonction `add_alias_first` en conservant l'ancien nom de liste.
    -   [ ]  S'assurer que la nouvelle fonction de renommage est rétro-compatible et ne cause pas de régression.

## Phase 3 : Documentation et Tests

- [ ]  **Documentation du code :**
    -   [ ]  Commenter le code Perl pour expliquer les nouvelles fonctions et la logique.
- [ ]  **Rédaction de la documentation pour la PR :**
    -   [ ]  Créer un document `ARCHITECTURE.md` décrivant les changements architecturaux.
    -   [ ]  Rédiger la description de la Pull Request (`PR_DESCRIPTION.md`).
- [ ]  **Tests de la fonctionnalité :**
    -   [ ]  Effectuer des tests manuels pour chaque nouvelle commande.
    -   [ ]  Ajouter des tests unitaires ou d'intégration automatisés si possible.
    -   [ ]  S'assurer qu'il n'y a pas de régression avec les fonctionnalités existantes.

---
