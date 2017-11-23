class CreateGamesUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :games, :users
  end
end
