class School < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :jobs, dependent: :destroy

  scope :activated, -> { where(active: true) }
end
