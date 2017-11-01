# DungeonMasterManager

DungeonMasterManager is an **application** designed to be a handy tool for game masters of TRPG kind games, also known as *Dungeon Masters*. The main focus of this app is to enable said Dungeon Masters to store and organize data related to their game and enable their players to access most of this information in an easy and controlled way.

Users of this application will be able to register as **Users**, wich will enable them to *create* or *join* **Games**. When a **user** creates a **game** it will automatically take on the role of *master*, and when it joins a game it will do so in the role of a *player*. Each **user** can master or play any number of **games** he/she so desires, but can only be part of each **game** as a *master* or a *player*.
To join a **game**, the **Dungeon Master** of said game must provide the joining **user** the *secret key*, which he/she must have defined when creating said **game**.

A **game** consists mainly of **users** and **characters**. Within each **game**, a **user** is able to create *n* number of **characters**. Only the *master* has access and control over every aspect of the **game**, while *players* are left with control over of their owned **characters**.
A **game** also contain of a set of **rules**, and a collection of lore entries, called **campaign notes**.

A **character** has many attributes:
* name: character's name
* race: character's race
* portrait: character's image
* **skills**: special abilities that a character posses
* **traits**: these are properties of a character, characteristics, things that might come into play in game
* **statuses**: a character's current buffs and debuffs, things that are affecting them temporarily
* **inventory**: a collection of the items carried by the character
* **achievements**: recognitions given when successfully completing a challenge or certain conditions
* **notes**: pieces of text owned by a character, like a notepad

Skill, Trait, Status, Inventory (which contains Items), Achievement, and Note are all classes on their own, with its properties that usually define a *name* and a *description*.
