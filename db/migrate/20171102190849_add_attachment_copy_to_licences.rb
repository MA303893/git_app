class AddAttachmentCopyToLicences < ActiveRecord::Migration[5.1]
  def self.up
    change_table :licences do |t|
      t.attachment :copy
    end
  end

  def self.down
    remove_attachment :licences, :copy
  end
end
