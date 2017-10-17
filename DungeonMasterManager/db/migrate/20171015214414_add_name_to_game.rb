class AddNameToGame < ActiveRecord::Migration[5.1]
  def up
    add_column :games, :name, :string
  end
  def down
    remove_column :games, :name
  end
end
