class Trait < ApplicationRecord
  #Associations
  belongs_to :character

  #Validations
  validates :character, :description, presence: true
  validates :description, length: { in: 1..255 }

end
