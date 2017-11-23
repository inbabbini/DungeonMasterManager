class Inventory < ApplicationRecord
  belongs_to :character
  has_many :items

  #Validations
  validates :capacity, presence: true
  validates :capacity, numericality: { only_integer: true }
end
