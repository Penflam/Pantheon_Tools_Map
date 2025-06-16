PantheonRoadMap
===============

Description
-----------
PantheonRoadMap est une application AutoIt qui surveille le presse-papier pour détecter automatiquement les coordonnées issues de la commande `/jumploc` du jeu *Pantheon: Rise of the Fallen*.

Lorsqu'une position est copiée, l'application génère une URL compatible avec le site https://shalazam.info, permettant de visualiser cette position (ou plusieurs) directement sur une carte interactive.

Fonctionnalités
---------------
- Surveillance automatique du presse-papier.
- Détection et parsing de la commande `/jumploc`.
- Création dynamique d'URL vers la carte Shalazam avec un ou plusieurs *pins*.
- Lancement automatique de Firefox (ou autre navigateur défini).
- Interface minimaliste avec contrôle du zoom, du délai de capture, et du mode multi-pin.
- Réactivation automatique de la fenêtre du jeu après rafraîchissement.
- Application toujours au premier plan.
- Bouton "Go Shalazam!" pour lancer manuellement la carte.

Fichiers inclus
---------------
- `main.au3` : script principal.
- `ini.ini` : fichier de configuration contenant le chemin d’accès au navigateur.
- `README.txt` : ce fichier d’explication.

Configuration
-------------
Le fichier `ini.ini` doit être présent dans le même dossier que le script. Il contient la section suivante :

```
[Path]
NavigatorPath=C:\Program Files\Mozilla Firefox\firefox.exe

```


Assurez-vous que le chemin spécifié correspond bien à l’emplacement de Firefox (ou autre navigateur souhaité). Sinon, modifiez ce chemin manuellement.

Utilisation
-----------
1. Lancez *Pantheon* et connectez-vous à votre personnage.
2. Exécutez le script `main.au3` (via l'éditeur SciTE ou un double-clic si compilé).
3. En jeu, tapez `/jumploc` pour copier votre position dans le presse-papier.
4. L’application détecte automatiquement la position copiée et prépare une carte.
5. Cliquez sur "Go Shalazam!" pour ouvrir la carte contenant vos positions.

Paramètres réglables via l’interface :
--------------------------------------
- **Zoom** : entre 3 et 9.
- **Delay** : intervalle de vérification du presse-papier (500 ms à 10 000 ms).
- **Track** : activation ou non du mode multi-pin (si désactivé, un seul point est affiché).

Limitations
-----------
- Le contrôle graphique de mini-carte est désactivé dans cette version.
- Le navigateur intégré n'est plus utilisé (meilleure compatibilité avec les navigateurs modernes).

🇫🇷 Pour les utilisateurs non développeurs

Si vous ne connaissez pas AutoIt, vous pouvez directement télécharger et utiliser la version exécutable :

📁 window_exe/pantheonroadmap.exe

    Note : Exécutable fourni tel quel. Exécutez uniquement si vous faites confiance à la source.




# PantheonRoadMap - Auto location on Shalazam

## Description

**PantheonRoadMap** is an AutoIt tool designed to automatically detect `/jumploc` coordinates from *Pantheon: Rise of the Fallen*, and open them in [shalazam.info](https://shalazam.info/maps/1).

It allows you to:
- monitor clipboard for `/jumploc`,
- store locations,
- open the map centered on the latest location,
- enable multi-pin mode,
- control zoom and refresh delay.

## Features

- Automatic clipboard monitoring for `/jumploc x y z heading`
- URL generation for Shalazam map
- Multi-pin support
- Adjustable **zoom** (3–9)
- Adjustable **delay** (500 ms to 10 s)
- Quick access button: **"Go Shalazam!"**
- Always on top window

## Requirements

- Windows
- [AutoIt](https://www.autoitscript.com/site/autoit/)
- Firefox browser (can be changed in `ini.ini`)

## File `ini.ini`

To customize the browser path:

```ini
[Path]
NavigatorPath=C:\Program Files\Mozilla Firefox\firefox.exe
```
🇬🇧 For non-developers

If you're not familiar with AutoIt, you can directly use the precompiled executable:

📁 window_exe/pantheonroadmap.exe

    Note: The executable is provided as-is. Run it only if you trust the source.

