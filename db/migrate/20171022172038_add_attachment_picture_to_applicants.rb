class AddAttachmentPictureToApplicants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :applicants do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :applicants, :picture
  end
end
