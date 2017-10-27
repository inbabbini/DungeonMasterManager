class Skill < ApplicationRecord
  #Associations
  belongs_to :character

  #Validations
  validates :character, :name, presence: true
  validates :name, :description, length: { in: 1..255 }
end
