class Character < ApplicationRecord
  belongs_to :game
	belongs_to :user
	# has_one :inventory
	# has_many :items, through: :inventory
	# has_many :skills
	# has_many :statuses
	# has_many :traits
	# has_many :notes
	# has_many :achievements

end
