# ledoux-webapp
Application web pour l’annotation de l’Architecture de Ledoux

## Install

Install BaseX from Zip

Clone the directory in basex/webapp or sym link to your local directory :

```
  ln -s /Users/myhome/path/ledouxWebapp /Applications/basex/webapp
```

## Structure de l’application

Les quatre types d’entités donnent chacune lieu à la création d’un formulaire

- Œuvre (Work)
- Bâtiment (Manifestation)
- Plaques (Manifestation)
- Planches/feuilles (Items)

Produire des listes

Lors de la création d’une entrée dans bâtiments ou plaques, créer automatiquement 

Afficher plusieurs formulaires dans une même page ? Imposer un ordre de travail ? Ouvrir un nouvel onglet ?

Si l’application avait été développée en JavaScript, on aurait peut-être pu travailler sur plusieurs ressources dans la même page. Comment faire la même chose avec XForms ?

Si on travaille sur une page unique, en attendant de pouvoir créer les onglets ou la mise en page avec CSS, travailler avec des id pour passer d’une partie de l’application à l’autre.

Page

- navigation
- Formulaire Bâtiment
- Formulaire Plaque
- Formulaire Œuvre

Scénario

- saisie des entrées par Planches
  L’utilisateur créée ou modifie une nouvelle planche. Il sélectionne une planche dans une liste ou bien choisi nouveau.
  Lors de la saisie, il peut choisir dans une liste déroulante des plaques déjà documentées ou sélectionne parmi les œuvres renseignées pour disposer d’une liste de plaques déjà documentées.
  Si elle existe, pas de pb.
  Si elle n’existe pas il peut créer une nouvelle entrée dans le système. On affiche le formulaire à renseigner.
  Il renseigne le formulaire de la plaque. Il peut naviguer entre les deux formulaires. 
  Au moment de l’enregistrement, il faut pouvoir enregistrer les deux instances, dans un ordre qui permette de pouvoir créer la relation.

  --> dans un tel scénario, comment faire pour qu’un formulaire puisse contrôler l’autre

