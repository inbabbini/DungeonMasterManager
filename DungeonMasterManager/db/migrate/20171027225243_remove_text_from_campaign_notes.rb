class RemoveTextFromCampaignNotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :campaign_notes, :text, :string
  end
end
