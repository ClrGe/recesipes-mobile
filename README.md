# 🧁reCESIpes🧁

_Cube web-mobile 2022 - Kevin Noah Maxime Claire_

Dernière édition : 22/07/2022 - Claire

### Presentation

🧁*reCESIpies*🧁 propose des recettes de cuisines variées accessibles à tous.

### Documentation

Le dossier */documentation* contient :

 - 📐 Le schéma UML de la base de données.
 - 💄 Les maquettes de la plateforme. (visible  aussi sur : https://miro.com/app/board/uXjVOwdAQsA=/)
 - 📚 Le cahier des charges du projet.
 - 📝 Le rapport du projet 

---

Schéma réalisé sur Draw.io (https://app.diagrams.net/)

---

Wireframe réalisé sur Miro (https://miro.com/app/board/uXjVOwdAQsA=/)

---

### Stack
 
    Front-end    : HTML5 + CSS (**Tailwind-css**)
    API          : PHP8.1.2 + Laravel 9
    ---
    ---
    Données      : MariaDB
    ---
    ---
    Serveur HTTP : NGINX
    ---
    ---
    Application : Flutter


### Hébergement

AWS - Instance EC2 T2.micro Ubuntu 22.04 

    - Mise en route le 19/06
    - ElasticIP pour éviter les changements d'adresse au reboot
    - Groupe de sécurité (filtrage IP des membres du groupe pour certains protocoles)
    - Ports 443 et 80 (https, http) accessible depuis partout

### Outils développement

    - VSCODE, PHPSTORM -> éditeur / IDE
    - GIT -> versioning
    - Discord -> Canal de communication et d'échanges

