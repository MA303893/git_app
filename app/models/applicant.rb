class Applicant < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications
  has_many :experiences
  has_many :qualifications
  has_many :licences
  has_many :dependents
  has_many :applicant_documents
end
