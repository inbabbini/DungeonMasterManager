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

# --------------- Create Skills --------------------

weapons_skills = ['Martial Melee Weapons', 'Martial Ranged Weapons', 'Simple Melee Weapons', 'Simple Ranged Weapons']
magic_skills = ['Fireball', 'Magic Missile', 'Midas', 'Iai', 'Stonemancy', 'Phyromancy', 'Burning Hands', 'Shilelagh', 'Fire bolt']

characters.each do | c |
  rand(0..3).times do
    c.skills << Skill.new(name: weapons_skills[rand(0..weapons_skills.size - 1)])
  end
  rand(0..3).times do
    c.skills << Skill.new(name: magic_skills[rand(0..magic_skills.size - 1)])
  end
end

# --------------- Create Statuses ------------------

debuffs = ['Poisoned', 'Frightened', 'Unconcious', 'Cursed', 'Bloodied', 'Injured', 'Bleeding', 'Burning', 'Frozen', 'Paralized', 'Anchored']
buffs = ['Blessed', 'Exalted', 'Shielded', 'Protected', 'Invulnerable']

characters.each do | c |
  rand(0..2).times do
    c.statuses << Status.new(name: debuffs[rand(0..debuffs.size - 1)])
  end
  rand(0..2).times do
    c.statuses << Status.new(name: buffs[rand(0..buffs.size - 1)])
  end
end

# ---------------- Create Traits ------------------

adjectives = ['Loves', 'Hates', 'Annoyed by', 'Looks like', 'Collects', 'Despices', 'Fond memories of', 'Believes in', 'Crusades against']
objects = ['Zombies', 'Dwarves', 'Turtles', 'Horses', 'Paintings', 'Doors', 'Mornings', 'Balds', 'People', 'High Society']

characters.each do | c |
  rand(0..2).times do
    c.traits << Trait.new(description: adjectives[rand(0..adjectives.size - 1)] + ' ' + objects[rand(0..objects.size - 1)])
  end
end

# ---------------- Create Notes ---------------------

events = ['we found', 'I found', 'we came across', 'I came across', 'we stumbled upon', 'I sumbled upon']
happenings = ['nothing special', 'some demons on the ruins', 'an old cementery', 'some castle ruins', 'a bridge', 'a broken bridge', 'a Sphinx on the road', 'a band of bald bandits', 'a strange merchant', 'a wandering mage', 'a coven of witches on the forest', 'a loomy swamp']

characters.each do | c |
  rand(0..3).times do | i |
    c.notes << Note.new(title: 'Day ' + i.to_s, content: 'Today ' + events[rand(0..events.size - 1)] + " " + happenings[rand(0..happenings.size - 1)])
  end
end

# ---------------- Create Achievements --------------

achievement_names = ['Animal Lover', 'Mass murderer', 'Over 9000!', 'Lore master', 'The Impaler', 'Skeleton Slayer', 'King of the Hill', 'Jack of All Trades, Master of None']
characters.each do | c |
  rand(0..1).times do
    c.achievements << Achievement.new(description: achievement_names[rand(0..achievement_names.size - 1)])
  end
end
