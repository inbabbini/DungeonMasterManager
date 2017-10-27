class User < ApplicationRecord
  # Model Associations
  has_many :mastered_games, class_name: 'Game', inverse_of: :dungeon_master, foreign_key: 'dungeon_master_id'
  has_and_belongs_to_many :played_games, class_name: 'Game'
  has_many :characters

  # Model Validations
  validates :name, :email, presence: true
  validates :name, :email, length: { in: 4..255 }
  validates :email, uniqueness: true

  # Class Methods
  def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.first_name + " " + auth.info.last_name
			user.email = auth.info.email
			user.picture = auth.info.image
			user.save!
    end
  end

  # Instance Methods
  def is_owner?(resource)
    resource.is_owned_by? self
  end

  def is_dm_or_player?(game)
    game.is_related_to? self
  end

end
