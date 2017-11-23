class AddAttachmentDocumentToCampaignNotes < ActiveRecord::Migration[5.1]
  def up
    add_attachment :campaign_notes, :document
  end

  def down
    remove_attachment :campaign_notes, :document
  end
end
