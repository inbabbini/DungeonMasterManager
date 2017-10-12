class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :secret_key
      t.references :dungeon_master

      t.timestamps
    end
  end
end
