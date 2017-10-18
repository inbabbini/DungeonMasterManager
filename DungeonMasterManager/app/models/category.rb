class Category < ApplicationRecord
  belongs_to :game
  has_many :campaign_notes
end
