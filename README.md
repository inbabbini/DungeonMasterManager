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

##About the project
Dependencies, configuration, setup, seeding and testing information:

* System dependencies:
  **ImageMagick**: You have to have installed ImageMagick on your system to properly use the Paperclip attachment functionality. Debian based distros, as Ubuntu usually have it.
**Ruby version**: 2.4
* Database
    Used **mySQL**. To configure locally, edit the file 'config/database.yml' and specify *user* and *password* values under *default* configuration key. This is to avoid more complex configuration via environment keys, which shoud be used on a production deployment.

* Database creation, initialization and seeding:
  To create the database, open up a console, navigate to the application root folder (in this case DungeonMasterManager), and execute `> rake db:create`. After this, to migrate the schema to the database, run `> rake db:migrate`, and finally, if you want to seed the application with some sample data, run `> rake db:seed`. Running just `> rake db:setup` should do the trick also, but for some reason it sometimes messes with the migration, so this is a more robust way.
  This seed data can be seen and edited in the 'db/seeds.rb' file.

* Default seed data explanation:
  By default, I have seeded the database with some registered users, 2 games, and various resources related to these games, such as those games' rules, campaign notes, player characters and the resources associated with said characters (skills, statuses, items, achievements, notes, etc). Much of this last resources seeds are kind of random, so inconsistencies (and sometimes hilarity) may arise.
  No attachments have been seeded, but functionality works.

* Some sample valid user and password combinations:
  * user: iron@dmm.com  password: ironiron -> DM of *game2*, player on *game1*
  * user: ponch@dmm.com  password: ponchponch -> DM of *game1*, player on *game2*
  * user: pain@dmm.com  password: painpain -> player on *game1* and *game2*

* How to run the test suite
  Test suit **TBD**
