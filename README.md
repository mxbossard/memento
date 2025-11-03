# Kezako ?

Dépôt git rassemblant mes notes.
Tentative de journal basé sur un dépôt git.
J'utilise le dépôt git pour centraliser mes notes sur plusieurs ordis

# Avantages
- Distribués sur plusieurs ordinateurs
- Historisé simplement grace aux commits git
- Pas de serveur
- Privé
- Possibilité simple de dev des features en shell autour de git


# Idées
- Ne pas modifier de fichiers commité pour éviter les conflits entre plusieurs ordinateurs ?
- Faire un pull avant de modifier un fichier ?
- Proposer de bypasser un pull si impossible de pull en option ?
- Push should squash commits ?
- Une commande pour push ?
- addEntry [MESSAGE]
- visualisation [-t THEME] 
- Chiffrer les documents sur le remote ?

# Use Cases

## Configuration
- L'URL du remote configuré en variable d'env

## Un script pour ajouter une entrée dans le journal
- Je lance vi (ou l'éditeur de texte préféré) pour abonder un fichier horodaté

## Un script pour visualiser le journal par ordre chronologique
- Lire le journal depuis la fin ?
- Editer le journal ?
- Construire un fichier temporaire listant les entrées et l'ouvrir avec vi ?
  - A la fermeture si modification sur une entrée que faire ?
    - créer un document thematique ?
    - interdire la modification autre que les tags ?
    - ajouter de la couleur sur les modifications ?
- Lire chaque entry avec un blame pour voir toutes les eventuels modifications ?

## Themes
- Je peux placer des theme sur des paragraphes avec des hastags


## Un script pour visualiser le journal par theme (hashtags)
- Theme par défaut pourrait être "diary". 


## Editer le journal ?
- Ajouter des tags sur des paragraphes.

## Documents thematiques
- Une classe de documents non chronologique spécifiques éditables attachés à un ou plusieurs themes ?
- Visualiser le journal par theme permet d'écrire dans un document non journalisé dédié au theme ?
- Comment merge ces documents ?

## Chiffrement sur public remote
Pour archiver son memento sur un dépot git public nous pourrions utiliser un chiffrement symetrique avant de push sur le remote.
- Chaque fichier pourrait donner lieu à un fichier chiffré
  - Lors de la modification d'un fichier ne modifie qu'un seul fichier chiffré ce qui devrai réduire les impacts sur la DB .git
- L'arborescence pourrait être conservée par soucis de simplicité
  - Est-ce que cela pose des problèmes de sécurité ? Facilitation du déchiffrement ?
- Chaque nom de fichier et dossier devrait être modifié (salt ?) avant chiffrement
  - Augmenter la sécurité en ne permettant pas d'inferer les nom des fichiers.i

- git-remote-gcrypt ?
  - Do a force push on every push
  - Not adapted for large repo


# Commit / Push cinematics

## Idea
- Reduce as much as possible commits => squash to 1 commit per day for diary.
- The day work could be on another branch and the branch could be merge squashed the day after.

## Cinematic
1- Check si il y a de vieilles branches "today" non merged
  - squash tous les branche chronologiquement par jour et les merge dans main
2- Switch sur la branch today
3- Edit the file requested
4- commit the file
5- push the branch3- Edit the file requested
4- commit the file
5- push the branch3- Edit the file requested
4- commit the file
5- push the branch
6- WARN if modifications on not daily files which was not pushed !

