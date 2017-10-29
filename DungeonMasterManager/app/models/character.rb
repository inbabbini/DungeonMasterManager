class Character < ApplicationRecord
  #Callbacks
  before_create :add_inventory

  #Associations
  belongs_to :game
	belongs_to :user
	has_one :inventory
	has_many :items, through: :inventory
	has_many :skills
	has_many :statuses
	has_many :traits
	has_many :notes
	has_many :achievements

  #Validations
  validates :name, :race, presence: true
  validates :name, :race, length: { in: 1..255 }

  #Instance methods
  def add_inventory
    self.inventory = Inventory.new(character: self, capacity: 30)
  end

end
