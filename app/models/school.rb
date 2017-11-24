class School < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :jobs, dependent: :destroy

  scope :activated, -> { where(active: true) }

  SCHOOLS_ALLOWED_PARAMS = [:country_of_citizenship, :country_of_birth, :eu_passport, :dob, :gender, :marital_status, :other_citizenship, :other_citizenship_country]

  def update_school(params)

  end

  def self.get_school_by_auth_token_and_email auth_token, email
    self.joins(:user).find_by('users.auth_token': auth_token, 'users.email': email)
  end
end
