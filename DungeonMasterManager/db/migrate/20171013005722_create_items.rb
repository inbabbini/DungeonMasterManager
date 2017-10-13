class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :inventory
      t.string :name
      t.string :description
      t.integer :quantity

      t.timestamps
    end
  end
end
