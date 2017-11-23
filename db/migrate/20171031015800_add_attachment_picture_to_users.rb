class AddAttachmentPictureToUsers < ActiveRecord::Migration[5.1]
  def up
    add_attachment :users, :picture
  end

  def down
    remove_attachment :users, :picture
  end
end
