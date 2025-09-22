# Architecture des alias de listes

Ce document décrit les changements architecturaux proposés pour intégrer la fonctionnalité d'alias dans Sympa.

## 1. Modélisation de la base de données

Une nouvelle table nommée `list_alias` sera ajoutée pour gérer les alias. Cette approche a été choisie pour maintenir la normalisation de la base de données et permettre à une liste d'avoir plusieurs alias de manière flexible.

La table aura la structure suivante :

-   `list_id` (INTEGER) : Identifiant de la liste parente, clé étrangère vers la table `list_table`.
-   `alias_name` (VARCHAR) : Le nom de l'alias (ex: `ancien-nom@domaine.fr`).
-   `created_at` (TIMESTAMP) : Date de création de l'alias.

## 2. Interaction avec les alias système

Les nouvelles commandes `add-alias` et `add-alias-first` devront interagir avec le système de messagerie du serveur pour créer une redirection des e-mails.

-   Le code Perl devra modifier le fichier de configuration des alias du serveur (généralement `/etc/aliases`).
-   Après la modification du fichier, la commande `newaliases` devra être exécutée pour que les changements soient effectifs. Cette opération nécessite des droits d'exécution spécifiques. Le code doit gérer cette étape de manière sécurisée.

## 3. Modification de `sympa.pl`

Les nouvelles commandes seront ajoutées à l'utilitaire en ligne de commande `sympa.pl`.

-   Le parsing des arguments de la ligne de commande sera mis à jour pour reconnaître `--add_alias`, `--add_alias_first` et `--remove_alias`.
-   Chaque commande pourra recevoir l'option --dry-run, qui affichera les actions prévues sans effectuer de modifications réelles.
-   Des fonctions dédiées seront créées pour chaque commande.
-   La commande existante `rename_list` sera modifiée pour appeler la fonction `add_alias_first` en interne, garantissant ainsi que l'ancien nom est conservé comme un alias.
