PantheonRoadMap
===============


![Aperçu de l'application](/image/pantheonroadmap.png "Aperçu de l'application").
![Aperçu de shalzam.info](/image/pantheonshalazaminfo.png "Aperçu de shalzam.info").
![Aperçu de l'application XP](/image/pantheon-xp.png "Aperçu de l'application XP").

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

📁 window_exe/pantheonroadmapv2.exe ( detection de l'XP ajouté )

    [Versions](window_exe/)
    
    Note : Exécutable fourni tel quel. Exécutez uniquement si vous faites confiance à la source.

PantheonRoadMap
===============

![Application Preview](/image/pantheonroadmap.png "Application Preview")

Description
-----------
PantheonRoadMap is an AutoIt application that monitors the clipboard to automatically detect coordinates from the `/jumploc` command used in the game *Pantheon: Rise of the Fallen*.

When a position is copied, the application generates a URL compatible with the https://shalazam.info website, allowing you to view that position (or several) directly on an interactive map.

Features
--------
- Automatic clipboard monitoring.
- Detection and parsing of the `/jumploc` command.
- Dynamic URL creation for the Shalazam map with one or more *pins*.
- Automatic launch of Firefox (or another defined browser).
- Minimal interface with zoom control, clipboard polling delay, and multi-pin mode.
- Automatic reactivation of the game window after refresh.
- Always-on-top application window.
- "Go Shalazam!" button to manually open the map.

Included Files
--------------
- `main.au3`: main script.
- `ini.ini`: configuration file containing the browser path.
- `README.txt`: this documentation file.

Configuration
-------------
The `ini.ini` file must be located in the same folder as the script. It contains the following section:

```
[Path]
NavigatorPath=C:\Program Files\Mozilla Firefox\firefox.exe

```


Make sure the specified path matches the actual location of Firefox (or your preferred browser). Otherwise, manually update the path.

Usage
-----
1. Launch *Pantheon* and log into your character.
2. Run the `main.au3` script (via the SciTE editor or double-click if compiled).
3. In-game, type `/jumploc` to copy your location to the clipboard.
4. The app automatically detects the copied position and prepares a map.
5. Click "Go Shalazam!" to open the map with your tracked positions.

Adjustable Interface Settings:
------------------------------
- **Zoom**: range from 3 to 9.
- **Delay**: clipboard check interval (500 ms to 10,000 ms).
- **Track**: enable or disable multi-pin mode (if disabled, only one point is shown).

Limitations
-----------
- The graphical mini-map control is disabled in this version.
- The embedded browser is no longer used (better compatibility with modern browsers).

For non-developer users
-----------------------
If you're unfamiliar with AutoIt, you can directly download and use the executable version:

📁 `window_exe/pantheonroadmap.exe`
📁 `window_exe/pantheonroadmap.exe` (xp detect added )

> Note: The executable is provided as-is. Only run it if you trust the source.
