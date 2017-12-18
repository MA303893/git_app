class Job < ApplicationRecord
  belongs_to :school
  has_many :applications
  has_many :applicants, through: :applications
end
