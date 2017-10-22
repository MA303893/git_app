class AddAttachmentFileToApplicantDocuments < ActiveRecord::Migration
  def self.up
    change_table :applicant_documents do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :applicant_documents, :file
  end
end
