class CampaignNote < ApplicationRecord
  #Associations
  has_attached_file :document
  belongs_to :game
  belongs_to :category

  #Validations
  validates :category, presence: true
  validates :title, :content, presence: true
  validates :title, length: { in: 2..255 }
  validates :content, length: { minimum: 1 }
  validates_attachment :document,
  size: { in: 0..2.megabytes }
  do_not_validate_attachment_file_type :document

  #Scopes
  scope :for_game, -> { where(game: game) }
  scope :for_players, -> { where(visible_by_players: true) }
end
