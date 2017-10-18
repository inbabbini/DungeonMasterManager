class CreateCampaignNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_notes do |t|
      t.references :category
      t.references :game
      t.string :title
      t.text :content
      t.boolean :visible_by_players
      t.string :dm_annotation
      t.string :text

      t.timestamps
    end
  end
end
