# Générateur de fichier NFO

Ce script génère un fichier NFO pour une vidéo donnée en scrapant grossièrement le site IMDb.

```bash
./create-nfo.sh [MOVIE_FOLER]
```

Pour chaque fichier vidéo du répertoire passé en paramètre, il y a trois résultats possibles :

## 1. Un seul id IMDb trouvé

Le fichier NFO est créé avec le nom exact du fichier.

Exemple `Arnaques, crimes et botanique (1998).nfo` :
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<movie>
  <title>Arnaques, crimes et botanique</title>
  <uniqueid default="true" type="imdb">tt0120735</uniqueid>
</movie>
```

## 2. Aucun id IMDb trouvé

Un fichier NFO est créé sans identifiant et avec le suffix `.none`.

Exemple `Zorglub.nfo.none` :
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<movie>
  <title>Zorglub</title>
  <uniqueid default="true" type="imdb"></uniqueid>
</movie>
```

## 3. Plusieurs id IMDb trouvés

Un fichier NFO est créé sans identifiant et avec le suffix `.many`.

Exemple `Primer.nfo.many` :
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<movie>
  <title>Primer</title>
  <uniqueid default="true" type="imdb"></uniqueid>
</movie>
```