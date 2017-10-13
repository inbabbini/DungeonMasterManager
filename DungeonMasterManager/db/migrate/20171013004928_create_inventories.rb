class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.references :character
      t.integer :capacity

      t.timestamps
    end
  end
end
