# README
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
