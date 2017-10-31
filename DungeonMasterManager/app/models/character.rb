class Character < ApplicationRecord
  #Callbacks
  before_create :add_inventory

  #Associations
  has_attached_file :avatar, styles: { normal: "300x300" }
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
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/png"] },
  size: { in: 0..2.megabytes }

  #Instance methods
  def add_inventory
    self.inventory = Inventory.new(character: self, capacity: 30)
  end

  def is_owned_by?(user)
    self.user == user
  end

end
