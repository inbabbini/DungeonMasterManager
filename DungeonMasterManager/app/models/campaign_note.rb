class CampaignNote < ApplicationRecord
  belongs_to :game
  belongs_to :category

  scope :for_game, -> { where(game: game) }
  scope :for_players, -> { where(visible_by_players: true) }
end
