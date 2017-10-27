class Note < ApplicationRecord
  #Associations
  belongs_to :character

  #Validations
  validates :character, :title, :content, presence: true
  validates :title, length: { in: 1..255 }
  
end
