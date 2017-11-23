class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.references :character
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
