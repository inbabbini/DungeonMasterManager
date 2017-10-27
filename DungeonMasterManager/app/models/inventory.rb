class Inventory < ApplicationRecord
  belongs_to :character
  has_many :items

  #Validations
  validates :character, :capacity, presence: true
  validates :capacity, numericality: { only_integer: true }
end
