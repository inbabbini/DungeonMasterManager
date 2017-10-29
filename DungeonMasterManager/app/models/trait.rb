class Trait < ApplicationRecord
  #Associations
  belongs_to :character

  #Validations
  validates :description, presence: true
  validates :description, length: { in: 1..255 }

end
