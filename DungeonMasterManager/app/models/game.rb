class Game < ApplicationRecord
  # Class Associations
  belongs_to :dungeon_master, class_name: 'User', inverse_of: :mastered_games, foreign_key: 'dungeon_master_id'
  has_and_belongs_to_many :players, class_name: 'User'
  has_many :characters
  has_many :categories
  has_many :campaign_notes

  #Class Validations
  validates :name, presence: true
  validates :name, length: { in: 1..255 }

  #Instance Methods
  def is_related_to?(user)
    return self.dungeon_master == user || user.in?(self.players)
  end

  def is_owned_by?(user)
    return self.dungeon_master == user
  end

end
