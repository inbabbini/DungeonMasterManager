class Rule < ApplicationRecord
  #Associations
  belongs_to :game

  #Validations
  validates :game, :description, presence: true
  validates :description, length: { in: 1..255 }

end
