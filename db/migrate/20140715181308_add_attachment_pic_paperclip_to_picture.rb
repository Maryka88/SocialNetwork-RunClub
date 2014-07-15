class AddAttachmentPicPaperclipToPicture < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :pictures, :pic
  end
end
