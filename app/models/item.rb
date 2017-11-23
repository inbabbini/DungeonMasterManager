class Item < ApplicationRecord
  #Associations
  belongs_to :inventory

  #Validations
  validates :name, :quantity, presence: true
  validates :name, length: { in: 1..255 }
  validates :quantity, numericality: { only_integer: true }

end
