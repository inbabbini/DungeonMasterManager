class Item < ApplicationRecord
  belongs_to :inventory
  # has_one :character, through: :inventory, inverse_of: :items
end
