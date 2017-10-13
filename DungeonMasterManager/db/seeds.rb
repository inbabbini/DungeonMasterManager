# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# --------------- Create Users ------------------

user1 = User.create(name: 'Iron')
user2 = User.create(name: 'Ponch')
user3 = User.create(name: 'Pain')
user4 = User.create(name: 'Richard')
user5 = User.create(name: 'Manzer')
user6 = User.create(name: 'Gunn')
user7 = User.create(name: 'Lau')
user8 = User.create(name: 'Diego')

# --------------- Create Games ------------------

game1 = Game.create(secret_key: 'altohash', dungeon_master: user2)
game1.players << [user1, user3, user4, user5, user6, user7, user8]

game2 = Game.create(secret_key: 'altohash2', dungeon_master: user1)
game2.players << [user2, user3, user4, user5, user6]

# --------------- Create Characters -------------
characters = []
characters << Character.create(game: game1, user: user1, name: 'Zareth', race: 'Extraplanar', description: 'Bad motherfucker')
characters << Character.create(game: game1, user: user3, name: 'Mathias', race: 'Dwarf', description: '')
characters << Character.create(game: game1, user: user4, name: 'Shiro', race: 'Human', description: '')
characters << Character.create(game: game1, user: user5, name: 'Manzer', race: 'Human', description: '')
characters << Character.create(game: game1, user: user6, name: 'Firenze', race: 'Centaur??', description: '')

characters << Character.create(game: game2, user: user2, name: 'Stabby', race: 'Wood Elf', description: '')
characters << Character.create(game: game2, user: user3, name: 'Macey', race: 'Hill Dwarf', description: '')
characters << Character.create(game: game2, user: user4, name: 'Axey', race: 'Half-orc', description: '')
characters << Character.create(game: game2, user: user5, name: 'Swordy', race: 'Dragonborn', description: '')



# ---------------- Create Items ------------------

weapons = ['sword', 'axe', 'dagger', 'short bow', 'short sword', 'lognsword', 'crossbow', 'hammer', 'warhammer']
weapon_properties = ['of flames', 'of ogre strength', 'of invisibility', 'of wind walking']
consumables = ['Minor healing potion', 'Healing Potion', 'Arrow', 'Bolt', 'Scroll', 'Bandages']

characters.each do | c |
  rand(0..3).times do
    c.inventory.items << Item.new(name: weapons[rand(0..(weapons.size - 1))] + " " + weapon_properties[rand(0..(weapon_properties.size - 1))])
  end
  rand(0..3).times do
    c.inventory.items << Item.new(name: consumables[rand(0..(consumables.size - 1))])
  end
end
