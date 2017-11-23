class CreateTraits < ActiveRecord::Migration[5.1]
  def change
    create_table :traits do |t|
      t.references :character
      t.string :description

      t.timestamps
    end
  end
end
