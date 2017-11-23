class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.references :game
      t.references :user
      t.string :name
      t.string :race
      t.string :description
      t.text :biography

      t.timestamps
    end
  end
end
