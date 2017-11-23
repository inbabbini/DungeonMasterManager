class Status < ApplicationRecord
  #Associations
  belongs_to :character

  #Validations
  validates :name, presence: true
  validates :name, length: { in: 1..255 }
end
