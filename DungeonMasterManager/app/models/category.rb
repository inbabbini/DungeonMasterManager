class Category < ApplicationRecord
  #Relations
  belongs_to :game
  has_many :campaign_notes

  #validations
  validates :name, presence: true
  validates :name, length: { in: 1..255 }

  #Scopes
  scope :for_game, ->(game) { where(game: game) }
end
