# Amélioration : Ajout de la gestion des alias de listes

### Contexte du projet

Ce projet vise à ajouter la fonctionnalité de gestion des alias de listes pour répondre à un besoin courant : la transition en douceur d'anciens noms de listes vers de nouveaux, plus cohérents, sans perturber les utilisateurs existants.

Actuellement, la commande `sympa.pl --rename_list` remplace le nom de liste, ce qui peut entraîner des problèmes de délivrabilité pour les utilisateurs qui continuent d'utiliser l'ancien nom.

### Fonctionnalités ajoutées

Trois nouvelles commandes ont été ajoutées à l'utilitaire `sympa.pl` :

* **`--add_alias=nom@robot --alias_name=nouvel_alias`**
    * Ajoute un nouvel alias à une liste existante. L'ancien nom de liste reste le nom principal.
* **`--add_alias_first=nom@robot --alias_name=nouvel_alias`**
    * Identique à `add_alias`, mais l'alias est ajouté de manière à ce que les alias du système de messagerie soient prioritaires (utilisant les redirections du haut de fichier).
* **`--remove_alias=nom@robot --alias_name=alias_à_supprimer`**
    * Supprime un alias d'une liste existante. Le nom principal de la liste ne peut pas être supprimé.

### Modification de la commande existante

La commande **`sympa.pl --rename_list`** a été modifiée pour devenir un raccourci qui utilise la nouvelle fonctionnalité d'alias. Au lieu de remplacer l'ancien nom, elle le conserve en tant qu'alias pour la liste nouvellement nommée. Cela assure une période de transition sans interruption pour les utilisateurs.

### Changements techniques

* **Base de données :** Ajout d'une nouvelle table `list_alias` pour stocker les alias de manière normalisée.
* **Alias système :** Les fonctions interagissent avec les alias du système de messagerie (ex: `/etc/aliases`) pour créer et supprimer les redirections.
* **Code Perl :** Le code de `sympa.pl` a été mis à jour avec les nouvelles options et fonctions. Le code existant pour `rename_list` a été adapté pour appeler la nouvelle fonctionnalité.

### Comment tester

1.  Cloner cette branche.
2.  Lancer le script de migration de la base de données.
3.  Utiliser les commandes suivantes pour valider le comportement :
    * `sympa.pl --add_alias=ma_liste@domaine.com --alias_name=ancien_nom@domaine.com`
    * `sympa.pl --rename_list=ma_liste@domaine.com --new_listname=nouvelle_liste@domaine.com`
    * `sympa.pl --remove_alias=nouvelle_liste@domaine.com --alias_name=ancien_nom@domaine.com`

Veuillez nous faire part de vos commentaires.
