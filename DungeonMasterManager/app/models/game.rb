class Game < ApplicationRecord
  # Class Associations
  belongs_to :dungeon_master, class_name: 'User', inverse_of: :mastered_games, foreign_key: 'dungeon_master_id'
  has_and_belongs_to_many :players, class_name: 'User'
  has_many :characters
  has_many :categories
  has_many :campaign_notes
  has_many :rules

  #Class Validations
  validates :name,
    presence: true,
    length: { in: 1..255 }

  validates :secret_key,
    presence: true,
    uniqueness: true,
    length: { in: 10..255 }

  #Instance Methods
  def add_player(user)
    if self.is_related_to? user
      return false, I18n.t('flash_messages.error.join_game')
    end

    self.players << user
    self.save
    return true, I18n.t('flash_messages.success.join_game', game: self.name)
  end

  def is_related_to?(user)
    return self.dungeon_master == user || user.in?(self.players)
  end

  def is_owned_by?(user)
    return self.dungeon_master == user
  end

end
