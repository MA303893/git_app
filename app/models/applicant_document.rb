class ApplicantDocument < ApplicationRecord
  belongs_to :applicant
  has_attached_file :file
  validates_attachment :file, presence: true, content_type: { content_type: "application/pdf" }
end
