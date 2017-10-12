class Game < ApplicationRecord
  belongs_to :dungeon_master, class_name: 'User', inverse_of: :mastered_games, foreign_key: 'dungeon_master_id'
  has_and_belongs_to_many :players, class_name: 'User'
end
