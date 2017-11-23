class AddAttachmentAvatarToCharacters < ActiveRecord::Migration[5.1]
  def up
    add_attachment :characters, :avatar
  end

  def down
    remove_attachment :characters, :avatar
  end
end
