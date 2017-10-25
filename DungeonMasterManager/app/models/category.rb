class Category < ApplicationRecord
  belongs_to :game
  has_many :campaign_notes

  scope :for_game, ->(game) { where(game: game) }
end
