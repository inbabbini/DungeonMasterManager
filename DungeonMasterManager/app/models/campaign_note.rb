class CampaignNote < ApplicationRecord
  #Associations
  belongs_to :game
  belongs_to :category

  #Validations
  validates :title, :content, presence: true
  validates :title, length: { in: 2..255 }
  validates :content, length: { minimum: 1 }

  #Scopes
  scope :for_game, -> { where(game: game) }
  scope :for_players, -> { where(visible_by_players: true) }
end
