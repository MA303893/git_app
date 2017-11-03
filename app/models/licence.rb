class Licence < ApplicationRecord
  belongs_to :applicant

  #adding paperclip for licence copy upload
  has_attached_file :copy
  validates_attachment_size :copy, :less_than => 2.megabytes
  validates_attachment :copy, content_type: { content_type: "application/pdf" }
end
