# Architecture des alias de listes

Ce document décrit les changements architecturaux nécessaires pour ajouter la gestion des alias de listes à Sympa.

## 1. Nouvelle table de base de données

Une table `list_alias` sera ajoutée pour stocker les alias associés à chaque liste.  
Colonnes principales : `list_id`, `alias_name`.

## 2. Interaction avec le système d'alias

Le système doit gérer les alias dans la base de données ainsi que dans le fichier `/etc/aliases` du serveur. L'application de la commande `newaliases` reste nécessaire après modification.

## 3. Modification de `sympa.pl`

Les nouvelles commandes seront ajoutées à l'utilitaire en ligne de commande `sympa.pl` :

- Le parsing des arguments de la ligne de commande sera mis à jour pour reconnaître `--add_alias`, `--add_alias_first`, et `--remove_alias`.
- Chaque commande pourra recevoir l'option `--dry-run`, qui affichera les actions prévues sans effectuer de modifications réelles.
- Des fonctions dédiées seront créées pour chaque commande.
- La commande existante `rename_list` sera modifiée pour appeler la fonction `add_alias_first` en interne, garantissant ainsi que l'ancien nom est conservé comme un alias.

## 4. Gestion des erreurs et rétrocompatibilité

Les fonctions doivent gérer les cas d'erreur (ex : alias déjà existant, liste non trouvée) et garantir la rétrocompatibilité avec les commandes existantes.