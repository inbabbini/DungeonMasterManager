class Achievement < ApplicationRecord
  belongs_to :character

  #Validations
  validates :name, presence: true
  validates :name, :description, length: { minimum: 1, maximum: 255 }
  
end
