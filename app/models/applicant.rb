class Applicant < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications
  has_many :experiences
  has_many :qualifications
  has_many :licences
  has_many :dependents
  has_many :applicant_documents

 #adding paperclip for profile pic upload
  has_attached_file :picture, styles: { medium: "300x300>",small: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_size :picture, :less_than => 1.megabytes
  validates_attachment :picture, content_type: { content_type: ['image/jpeg', 'image/png'] }

 #adding paperclip for resume upload
  has_attached_file :resume
  validates_attachment_size :resume, :less_than => 1.megabytes
  validates_attachment :resume, content_type: { content_type: "application/pdf" }
end
